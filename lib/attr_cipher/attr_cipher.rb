require 'active_record'
require 'active_support/all'

module AttrCipher
  extend ActiveSupport::Concern

  class << self
    attr_accessor :cipher
    attr_reader :secret
  end

  def self.secret=(value)
    @secret = value.to_s
  end

  self.cipher = Cipher
  self.secret = ''

  module ClassMethods
    def attr_cipher(*args, secret: AttrCipher.secret, cipher: AttrCipher.cipher, serialize: false)
      args.each do |attribute|
        define_cipher_attribute(attribute, secret, cipher, serialize)
      end
    end

    private

    def define_cipher_attribute(attribute, secret, cipher, serialize)
      define_method attribute do
        value = instance_variable_get("@#{attribute}")
        cipher_value = send("#{attribute}_cipher") unless value
        value = cipher.decrypt(secret, cipher_value, serialize) if cipher_value
        instance_variable_set("@#{attribute}", value)
      end

      define_method "#{attribute}=" do |value|
        instance_variable_set("@#{attribute}", value)
        send("#{attribute}_cipher=", nil)
        send("#{attribute}_cipher=", cipher.encrypt(secret, value, serialize)) if value && value != ""
      end
    end
  end
end

ActiveRecord::Base.send :include, AttrCipher
