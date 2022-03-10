# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

require_relative 'exer/version'
require_relative 'exer/make'

# Build executable gem installers for Windows, Linux and Mac.
# Go language is bundled together within the app,
# so all you need is Linux and Ruby.
#
# @note Do not use same name for installer-name and your-gem-binary-name.
#
# @see Exer::Make
#
# @example Build gem runner that will install gem if not installed
#
#   # make gem with binary named same as gem
#   # upload it to rubygems
#   # executable will install gem if not installed, and open it
#   Exer.make do |app|
#     app.filename = 'my_gem run' # do not use same name as gem
#     app.add :gem_run, 'my_gem'
#   end
#
# @example Build executable installers for gem
#
#   Exer.make('my_gem install') do |app|
#     # if you only make installer, add wait_for_enter
#     app.add :gem_install, 'my_gem'
#     app.wait_for_enter
#   end
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
  #     build.filename = 'my_gem_name'
  #     build.add :gem_install, 'my_gem_name'
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

  class << self
    def system_golang?
      @system_golang == true
    end

    def system_golang=(arg)
      @system_golang = arg
    end
  end
end
