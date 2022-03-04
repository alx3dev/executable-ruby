# Copyright (C) 2022  Aleksandar Subasic
# frozen_string_literal: true

require_relative 'exer/version'
require_relative 'exer/make'

module Exer
  def self.make(opts = {})
    maker = Exer::Make.new(opts[:filename])
    maker.add_defaults
    yield(maker) if block_given?
    maker.make opts[:exclude]
  end
end
