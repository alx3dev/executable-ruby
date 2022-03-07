# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

require_relative 'exer/version'
require_relative 'exer/make'

# Build executable gem installers for Windows, Linux and Mac.
# Go language is bundled together within the app,
# so all you need is linux and ruby.
#
# @see Exer::Make
#
# @example Build executable installers for glimmer gem
#
#  Exer.make('glimmer-installer') do |app|
#    app.add :gem_install, 'glimmer-dsl-libui'
#  end
#
module Exer
  # Class method #make is a shortcut to initialize new Maker instance,
  # and add default functions.
  #
  # @see Exer::Make
  #
  # @example Build Windows installer for gem 'my_gem'
  #
  #   Exer.make(exclude: [:windows, :darwin]) do |build|
  #     build.filename = 'my_gem'
  #     build.add :gem_install, 'my_gem'
  #   end
  #
  # @param [Hash] options Optional.
  # @option options [String] filename Optional. Filename, defined here or inside a block.
  # @option options [Symbol] exclude Optional. Platforms to exclude when making binaries.
  # @yield [Exer::Make] New instance of make class, with added default functions.
  #
  def self.make(options = {})
    maker = Exer::Make.new(options[:filename])
    maker.add_defaults
    yield(maker) if block_given?
    maker.build options[:exclude]
  end
end
