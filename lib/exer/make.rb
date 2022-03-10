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

    attr_reader :import, :functions, :main

    attr_accessor :filename
    alias >> filename=

    # golang source directory path
    GO = File.expand_path(__FILE__)
             .gsub('lib/exer/make.rb', 'go/bin/go').freeze

    PLATFORMS = %i[linux darwin windows].freeze

    # Prepare go file - give it a name and import packages.
    # This is also a name of final binaries.
    #
    # @example
    #   app = Exer::Make.new 'my_gem_name'
    #
    # @param [String] filename **Required**. Name of binaries.
    #
    def initialize(filename)
      @filename = filename
      @import = FUNCTION[:go_packages]
      @main = "\nfunc main() {"
      @functions = "\n"
      @wfe = false
    end

    # Define go functions, so we can use them in main.
    # They are defined in ::Template, and automatically added to file.
    #
    # @see Template::FUNCTION
    #
    # @example Define function gem_install
    #   app.add_function :gem_install
    #
    # @param [Symbol] function_name **Required**. Name of Template::FUNCTION.
    # @return [String]
    #
    def add_function(function_name)
      @functions += "\n#{FUNCTION[function_name]}"
    end

    # Add previously defined function to go-main, to be executed.
    #
    # @see Template::MAIN_FUNCTION
    #
    # @example
    #   app.add :gem_install, 'my_gem_name'
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
    alias << add

    # Make executable for platforms we want.
    # Functions are written to the file, built into binaries, and file is removed.
    #
    # If you build binary only with gem_install, do not forget
    # to add **wait_for_enter**, so user must press enter after installation.
    # Don't use with :gem_run.
    #
    # @example Build for Windows, Linux, Mac
    #   app.build do |x|
    #     x.add_defaults
    #     x.add :gem_install, 'my-gem-name'
    #     x.wait_for_enter
    #   end
    #
    # @example Build gem installer and runner
    #   app.build do |x|
    #     x.add :gem_run, 'my-gem-name'
    #   end
    #
    # @param [Symbol] exclude Optional. Platforms to exclude when making binaries. Also accept array of symbols.
    # @return [Boolean]
    #
    def build(exclude = nil)
      build_binaries exclude
      true
    rescue StandardError => e
      puts e.message
      false
    end

    # Add functions to the go file, and check if ruby is installed.
    #
    def add_defaults
      %i[binary_exist ruby_exist ruby_exec gem_install gem_run].each do |x|
        add_function x
      end
      add :ruby_exist
    end

    # Wait for user to press [ENTER] before finish.
    # Don't use with :gem_run
    #
    def wait_for_enter
      @wfe = true
    end

    private

    def build_binaries(without_platforms = nil)
      write_go_file
      PLATFORMS.each do |platform|
        next if Array(without_platforms).include? platform

        extension = case platform
                    when :windows then '.exe'
                    when :darwin  then '.app'
                    end

        go_build(platform, extension)
      end
      File.delete "#{filename}_install.go"
    end

    def write_go_file
      if @wfe
        import = @import.sub(')', '"bufio"; )')
        main = @main + WAIT_FOR_ENTER
      else
        import = @import
        main = @main
      end
      go_file = "#{import}#{@functions}#{main}\n}"
      File.write "#{filename}_install.go", go_file
    end

    def go_build(os, ext = nil)
      go_path = Exer.system_golang? ? 'go' : GO
      `GOOS=#{os} #{go_path} build -o #{filename}#{ext} #{filename}_install.go`
    end
  end
end
