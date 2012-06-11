# -*- encoding: utf-8 -*-
require File.expand_path('../lib/kobza_crm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Andrew Shcheglov']
  gem.email         = ['godwindock@gmail.com']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ''

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'kobza_crm'
  gem.require_paths = ['lib']
  gem.version       = KobzaCrm::VERSION

  gem.add_dependency 'bson_ext'
  gem.add_development_dependency 'rspec'
end
