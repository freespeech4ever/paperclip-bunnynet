# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name          = "paperclip-bunnynet"
  gem.version       = "0.5.0"

  gem.homepage      = "https://github.com/freespeech4ever/paperclip-bunnynet"
  gem.description   = %q{Extends Paperclip with Bunny.net storage.}
  gem.summary       = gem.description
  gem.authors       = ["Fosco Marotto"]
  gem.email         = ["fosco@fosco.com"]

  gem.files         = Dir["lib/**/*"] + ["README.md", "LICENSE", "paperclip-bunnynet.gemspec"]
  gem.require_path  = "lib"

  gem.required_ruby_version = ">= 2.5.0"

  gem.license       = "MIT"

  gem.add_dependency "paperclip", ">= 3.1", "< 7"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "vcr", ">= 2.6"
  gem.add_development_dependency "webmock", ">= 1.8"
  gem.add_development_dependency "activerecord", ">= 3.2"
end