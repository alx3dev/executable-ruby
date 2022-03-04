# Copyright (C) 2022  Aleksandar Subasic
# frozen_string_literal: true

require_relative 'exer/version'
require_relative 'exer/make'

module Exer
  def self.make(filename = nil)
    maker = Exer::Make.new(filename)
    maker.add_defaults
    yield(maker) if block_given?
    maker.make
  end
end
