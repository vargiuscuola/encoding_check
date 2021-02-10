# frozen_string_literal: true

require_relative "lib/extensions/string/encoding_check/version"

Gem::Specification.new do |spec|
  spec.name          = "encoding_check"
  spec.version       = Extensions::String::EncodingCheck::VERSION
  spec.authors       = ["Stefano Vargiu"]
  spec.email         = ["vstefanoxx@gmail.com"]

  spec.summary       = "Minimal library to enforce string encoding"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/vargiuscuola/encoding_check"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vargiuscuola/encoding_check"
  spec.metadata["changelog_uri"] = "https://github.com/vargiuscuola/encoding_check/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Specific to this gem (added by Stefano)
  spec.add_dependency "rchardet19", "~> 1.3"
  spec.add_dependency "thor", "~> 1.1"
  spec.add_development_dependency "aruba", "~> 1.0"
  spec.add_development_dependency "cucumber", "~> 5.3"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop", "~> 1.9", ">= 1.9.1"
  spec.add_development_dependency "rubocop-rake", "~> 0.5.1"
  spec.add_development_dependency "rubocop-rspec", "~> 2.2"
end
