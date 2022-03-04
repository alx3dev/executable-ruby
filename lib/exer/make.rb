# Copyright (C) 2022  Aleksandar Subasic
# frozen_string_literal: true

require_relative 'template/functions'
require_relative 'template/main'

module Exer
  class Make
    include Template

    attr_reader :file
    attr_accessor :filename

    def initialize(filename = nil)
      @file = Function[:go_packages]
      @main = "\nfunc main() {"
      @filename = filename
    end

    def add(function, opt = nil)
      @main += "\n"
      func = String.new Main_Function[function]
      func.gsub!('COMMAND', opt) unless opt.nil?
      @main += func
    end

    def add_function(name)
      @file += "\n"
      @file += Function[name]
    end

    def make(exclude = nil)
      @main += Finalize_Main unless @main.include?(Finalize_Main)
      go_file = @file + @main
      File.write "#{filename}_install.go", go_file
      system "GOOS=linux go build -o #{filename} #{filename}_install.go" unless Array(exclude).include?(:linux)
      system "GOOS=windows go build -o #{filename}.exe #{filename}_install.go" unless Array(exclude).include?(:windows)
      system "GOOS=darwin go build -o #{filename}.app #{filename}_install.go" unless Array(exclude).include?(:darwin)
      File.delete "#{filename}_install.go"
    end

    def add_defaults
      %i[binary_exist ruby_exist ruby_exec gem_install].each do |x|
        add_function x
      end
      add :ruby_exist
    end
  end
end
