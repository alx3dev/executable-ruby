# frozen_string_literal: true

require_relative "lib/exer/version"

Gem::Specification.new do |spec|
  spec.name = "executable-ruby"
  spec.version = Exer::VERSION
  spec.authors = ["alx3dev"]
  spec.email = ["alx3dev@gmail.com"]

  spec.summary = "Cross-compile executables to install ruby-gems."

  spec.description = <<~DESC
    Cross-compile "ruby-gem-install" executables for three major platforms (Windows, Linux and Mac).
    Require golang installed.
  DESC

  spec.homepage = "https://www.github.com/alx3dev/executable-ruby"
  spec.license = "GPLv3"
  spec.required_ruby_version = ">= 2.7.5"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = %w[
    lib/exer.rb
    lib/exer/make.rb
    lib/exer/version.rb
    lib/exer/template/functions.rb
    lib/exer/template/main.rb
  ]

  spec.bindir = "bin"
  spec.executables = ["exer"]
  spec.require_paths = ["lib"]
end
