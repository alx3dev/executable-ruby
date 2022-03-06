# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

require_relative 'template/functions'
require_relative 'template/main'

module Exer
  class Make
    include Template

    # golang source directory path
    GO = File.expand_path(__FILE__)
             .gsub('lib/exer/make.rb', 'go/bin/go').freeze

    # allowed platforms to build binaries
    PLATFORMS = %i[linux darwin windows].freeze

    attr_reader :functions, :main
    attr_accessor :filename

    # Prepare go file - give it a name and import packages.
    # This is also a name of final executables.
    #
    # @param [String] filename **Required**. Name of executables.
    #
    def initialize(filename)
      @filename = filename
      @main = "\nfunc main() {"
      @functions = FUNCTION[:go_packages]
    end

    # Define go functions, so we can use them in main.
    # Functions are defined in ::Template
    #
    # @see Template
    # @see Template::FUNCTION
    # @see Template::MAIN_FUNCTION
    #
    # @param [Symbol] function_name **Required**. Name of Template::FUNCTION.
    # @return [String]
    #
    def add_function(function_name)
      @functions += "\n"
      @functions += FUNCTION[function_name]
    end

    # Add previously defined function to go-main, to be executed.
    # Functions are defined in ::Template.
    #
    # @see Template
    # @see Template::FUNCTION
    # @see Template::MAIN_FUNCTION
    #
    # @param [Symbol] function **Required**. Function name from ::Template.
    # @param [String] arg Optional. For functions that require argument (like gem install).
    #
    # @return [String]
    #
    def add(function, arg = nil)
      func = String.new MAIN_FUNCTION[function]
      func.gsub!('COMMAND', arg) unless arg.nil?
      @main += "\n#{func}"
    end

    # Build executable for platforms we want.
    # Functions are written to the file, built into binaries, and file is removed.
    #
    # @param [Symbol] exclude_platforms Optional. Platforms to exclude when making binaries. Write as array of symbols.
    # @return [Boolean]
    #
    def make(exclude_platforms = nil)
      build_executables exclude_platforms
      true
    rescue StandardError => e
      puts e.message
      false
    end

    # Add functions that we always need.
    # This method is mostly for testing purposes.
    #
    def add_defaults
      %i[binary_exist ruby_exist ruby_exec gem_install].each do |x|
        add_function x
      end
      add :ruby_exist
    end

    private

    def build_executables(without_platforms = nil)
      write_go_source_code

      PLATFORMS.each do |platform|

        # 3.1 => next if platform in Array(without_platforms)
        next if Array(without_platforms).include? platform

        extension = case platform
                    when :windows then '.exe'
                    when :darwin  then '.app'
                    end

        build(platform, extension)
      end
      File.delete "#{filename}_install.go"
    end

    def write_go_source_code
      go_file = @functions + @main + WAIT_FOR_ENTER_TO_EXIT
      File.write "#{filename}_install.go", go_file
    end

    def build(os, ext = nil)
      system "GOOS=#{os} #{GO} build -o #{filename}#{ext} #{filename}_install.go"
    end
  end
end
