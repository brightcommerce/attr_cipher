require './lib/attr_cipher/version'

Gem::Specification.new do |spec|
  spec.name                  = 'attr_cipher'
  spec.version               = AttrCipher::VERSION::STRING
  spec.summary               = AttrCipher::VERSION::SUMMARY
  spec.description           = AttrCipher::VERSION::DESCRIPTION
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.2'

  spec.authors               = ['Jurgen Jocubeit']
  spec.email                 = ['support@brightcommerce.com']
  spec.homepage              = 'https://github.com/brightcommerce/attr_cipher'
  spec.license               = 'MIT'
  spec.metadata              = {'copyright' => 'Copyright 2017-2018 Brightcommerce, Inc.'}

  spec.require_paths         = ['lib']
  spec.files                 = Dir.glob('{lib, spec}/**/*') + %w(README.md CHANGELOG.md MIT-LICENSE)

  spec.add_runtime_dependency('activesupport', '>= 4.2.6')
  spec.add_runtime_dependency('activerecord', '>= 4.2.6')

  spec.add_development_dependency('rake', '~> 10.5')
  spec.add_development_dependency('rspec', '~> 3.4')
  spec.add_development_dependency('sqlite3', '~> 1.3')
  spec.add_development_dependency('factory_bot')
  spec.add_development_dependency('simplecov', '~> 0.16.1')
end
