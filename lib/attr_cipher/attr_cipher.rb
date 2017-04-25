require 'active_record'
require 'active_support/all'

module AttrCipher
  extend ActiveSupport::Concern

  class << self
    attr_accessor :cipher
    attr_reader :secret
  end

  def self.secret=(value)
    validate_secret(value.to_s)
    @secret = value.to_s
  end

  def self.validate_secret(value)
    if value.size < 100
      offending_line = caller.reject { |entry|
        entry.include?(__dir__) || entry.include?("forwardable.rb")
      }.first[/^(.*?:\d+)/, 1]
      warn "[attr_cipher] secret must have at least 100 characters (called from #{offending_line})"
    end
  end

  self.cipher = Cipher
  self.secret = ''

  module ClassMethods
    def attr_cipher(*args, secret: AttrCipher.secret, cipher: AttrCipher.cipher)
      AttrCipher.validate_secret(secret)
      args.each do |attribute|
        define_cipher_attribute(attribute, secret, cipher)
      end
    end

    private

    def define_cipher_attribute(attribute, secret, cipher)
      define_method attribute do
        value = instance_variable_get("@#{attribute}")
        cipher_value = send("#{attribute}_cipher") unless value
        value = cipher.decrypt(secret, cipher_value) if cipher_value
        instance_variable_set("@#{attribute}", value)
      end

      define_method "#{attribute}=" do |value|
        instance_variable_set("@#{attribute}", value)
        send("#{attribute}_cipher=", nil)
        send("#{attribute}_cipher=", cipher.encrypt(secret, value)) if value && value != ""
      end
    end
  end
end

ActiveRecord::Base.send :include, AttrCipher
