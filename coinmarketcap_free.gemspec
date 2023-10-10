# frozen_string_literal: true

require_relative "lib/coinmarketcap_free/version"

Gem::Specification.new do |spec|
  spec.name = "coinmarketcap_free"
  spec.version = CoinmarketcapFree::VERSION
  spec.authors = ["Vitalii Bakun"]
  spec.email = ["crossdoh@gmail.com"]

  spec.summary = "Cryptocurrency information from the Coinmarketcap site without a key."
  spec.description = "Cryptocurrency information from the Coinmarketcap site without a key."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["source_code_uri"] = 'https://github.com/vitalii-bakun/coinmarketcap_free'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
