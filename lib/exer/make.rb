# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

require_relative 'template/functions'
require_relative 'template/main'

module Exer
  # Make class handle all the logic that we need to make binaries.
  # Functions are written to the file and removed after go build.
  # By default all three platforms are used, but you can also exclude each of them.
  #
  class Make
    include Template

    # golang source directory path
    GO = File.expand_path(__FILE__)
             .gsub('lib/exer/make.rb', 'go/bin/go').freeze

    # allowed platforms to build binaries
    PLATFORMS = %i[linux darwin windows].freeze

    # Defined functions in go file
    attr_reader :functions

    # Defined functions to execute in go-main
    attr_reader :main

    # Name of final binaries
    attr_accessor :filename

    # Prepare go file - give it a name and import packages.
    # This is also a name of final binaries.
    #
    # @example
    #   exer = Exer::Make.new 'my_gem_name'
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
    # @example Define function gem_install
    #   exer.add_function :gem_install
    #
    # @param [Symbol] function_name **Required**. Name of Template::FUNCTION.
    # @return [String]
    #
    def add_function(function_name)
      @functions += "\n"
      @functions += FUNCTION[function_name]
    end

    # Add previously defined function to go-main, to be executed.
    #
    # @see Template
    # @see Template::FUNCTION
    # @see Template::MAIN_FUNCTION
    #
    # @example
    #   exer.add :gem_install, 'my_gem_name'
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

    # Make executable for platforms we want.
    # Functions are written to the file, built into binaries, and file is removed.
    #
    # @example Build for Windows, Linux, Mac
    #   exer.build do |x|
    #     x.add_defaults
    #     x.add :gem_install, 'my-gem-name'
    #   end
    #
    # @param [Symbol] exclude Optional. Platforms to exclude when making binaries. Also accept array of symbols.
    # @return [Boolean]
    #
    def build(exclude = nil)
      build_executables exclude
      true
    rescue StandardError => e
      puts e.message
      false
    end

    # Add functions that we always need, and check if ruby is installed.
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

        go_build(platform, extension)
      end
      File.delete "#{filename}_install.go"
    end

    def write_go_source_code(without_wait = nil)
      go_file = @functions + @main
      go_file += WAIT_FOR_ENTER_TO_EXIT unless without_wait
      go_file += "\n}"
      File.write "#{filename}_install.go", go_file
    end

    # don't overwrite gem files - append _install to the name of go file
    def go_build(os, ext = nil)
      system "GOOS=#{os} #{GO} build -o #{filename}_install#{ext} #{filename}_install.go"
    end
  end
end
