# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

require_relative 'exer/version'
require_relative 'exer/make'

# Build executables to install your gem on Win, Linux and Mac.
# Go language is bundled together within the app,
# so all you need is linux and ruby.
#
# @example Build executable installers for glimmer gem
#
#  Exer.make('glimmer-installer') do |app|
#    app.add :gem_install, 'glimmer-dsl-libui'
#  end
#
module Exer
  def self.make(opts = {})
    maker = Exer::Make.new(opts[:filename])
    maker.add_defaults
    yield(maker) if block_given?
    maker.make opts[:exclude]
  end
end
