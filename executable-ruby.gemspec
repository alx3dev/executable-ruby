# frozen_string_literal: true

require_relative 'lib/exer/version'

Gem::Specification.new do |spec|
  spec.name = 'executable-ruby'
  spec.version = Exer::VERSION
  spec.authors = ['alx3dev']
  spec.email = ['alx3dev@gmail.com']

  spec.summary = 'Cross-compile executables to install and/or run ruby-gems.'

  spec.description = <<~DESC
    Cross compile executables to install and/or run ruby gems from rubygems.org.
  DESC

  spec.homepage = 'https://www.github.com/alx3dev/executable-ruby'
  spec.license = 'GPL-3.0'
  spec.required_ruby_version = '>= 2.7.5'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = %w[
    lib/exer.rb
    lib/exer/make.rb
    lib/exer/version.rb
    lib/exer/template/functions.rb
    lib/exer/template/main.rb
    README.md
    LICENSE
    Gemfile
    executable-ruby.gemspec
  ]

  spec.bindir = 'bin'
  spec.executables = %w[exer setup]
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'rake', '~> 13.0'
end
