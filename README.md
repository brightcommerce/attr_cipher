[![Gem Version](https://badge.fury.io/rb/attr_cipher.svg)](https://badge.fury.io/rb/attr_cipher)
[![Build Status](https://travis-ci.org/brightcommerce/attr_cipher.svg?branch=master)](https://travis-ci.org/brightcommerce/attr_cipher)
[![codecov.io](https://codecov.io/github/brightcommerce/attr_cipher/coverage.svg?branch=master)](https://codecov.io/github/brightcommerce/attr_cipher?branch=master)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/brightcommerce/attr_cipher/pulls)

# AttrCipher

[**AttrCipher**](https://github.com/brightcommerce/attr_cipher) provides functionality to store encrypted attributes in ActiveRecord models. Values are encrypted and decrypted transparently.

Using the same secret for both encryption of plaintext and decryption of ciphertext, **AttrCipher** uses a method that is known as a symmetric-key algorithm, specifically the Advanced Encryption Standard Cipher-Block Chaining algorithm with a 256bit key (AES-256-CBC). However, you can provide your own cipher algorithm to **AttrCipher**, if you prefer. As a side note, 256bit AES is what the United States government uses to encrypt information at the Top Secret level.

## Installation

To install add the following line to your `Gemfile`:

``` ruby
gem 'attr_cipher'
```

And run `bundle install`.

## Dependencies

Runtime:
- activerecord (>= 4.2.6)
- activesupport (>= 4.2.6)

Development/Test:
- rake (~> 10.5)
- rspec (~> 3.4)
- sqlite3 (~> 1.3)
- simplecov (~> 0.11.2)
- factory_girl (~> 4.5)

## Compatibility

Tested with Ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15] against ActiveRecord 5.1.3 on macOS Sierra 10.12.6 (16G29).

**AttrCipher** uses OpenSSL to perform the cipher.

## Usage

**AttrCipher** uses a global secret by default and it must be at least 100 characters or more. You can set the secret by setting `AttrCipher.secret`; (e.g. `$ openssl rand -hex 50`).

```ruby
AttrCipher.secret = ENV['SECRET_KEY']
```

You can also set the secret on a per attribute basis.

```ruby
class User
  attr_cipher :api_key, secret: ENV['USER_API_KEY_SECRET']
end
```

Add the attribute as a column to your ActiveRecord migration with `_cipher` appended to the attribute name:

```ruby
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.text :api_key_cipher
  end
end
```

Attributes to be encrypted are declared using the `attr_cipher` class method in your model:

```ruby
class User < ActiveRecord::Base
  attr_cipher :api_key
end
```

In the above example, **AttrCipher** automatically creates the `#api_key` getter and `#api_key=` setter. The getter automatically decrypts the return value. The setter encrypts the value provided and stores it in the `api_key_cipher` column.

If you don't want to use the AES-256-CBC cipher, you can provide your own cipher object. Define an object that responds to `encrypt(secret, value)` and `decrypt(secret, value)` class methods:

```ruby
module CustomCipher
  def self.encrypt(secret, value)
    value.to_s.reverse
  end
  def self.decrypt(secret, value)
    value.to_s.reverse
  end
end
```

Then pass the custom cipher object to the `cipher` option of the `attr_cipher` class method:

```ruby
class User < ActiveRecord::Base
  attr_cipher :api_key, cipher: CustomCipher
end
```

Sometimes we need to store values that are aren't strings. In order to encrypt other value types  you can pass the `serialize` option with a value of `true` to the `attr_cipher` class method:

```ruby
class User < ActiveRecord::Base
  attr_cipher :api_key, serialize: true
end
```

Using the serialize option will cause the value to be serialized and deserialized using YAML during the encrypting and decrypting process. No changes are necessary to the column type in the table migration, it should remain as `text`.

## Tests

Tests are written using Rspec, FactoryBot and Sqlite3. There are 17 examples with 100% code coverage.

To run the tests, execute the default rake task:

``` bash
bundle exec rake
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credit

I would like to thank [Nando Vieira](http://nandovieira.com/) for his [encrypt_attr](https://github.com/fnando/encrypt_attr) gem from which some of the code was derived. The `encrypt_attr` gem is a better fit for non-ActiveRecord use.

This gem was written and is maintained by [Jurgen Jocubeit](https://github.com/JurgenJocubeit), CEO and President Brightcommerce, Inc.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Copyright

Copyright 2017-2018 Brightcommerce, Inc.
