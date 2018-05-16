require 'base64'
require 'digest/sha2'
require 'openssl'

module AttrCipher
  class Cipher
    ALGORITHM = "AES-256-CBC".freeze

    def initialize(secret = nil)
      @secret = secret
    end

    def cipher(mode, value)
      cipher = OpenSSL::Cipher.new(ALGORITHM).public_send(mode)
      digest = Digest::SHA256.digest(@secret)
      cipher.key = digest
      cipher.iv = digest[0...cipher.iv_len]
      cipher.update(value) + cipher.final
    end

    def decode(value)
      Base64.decode64(value)
    end

    def decrypt(value)
      if @secret.nil? || (@secret.respond_to?(:size) && @secret.size < 100)
        raise SecretException.new("Secret not set or must have at least 100 characters.")
      else
        cipher(:decrypt, decode(value))
      end
    end

    def encode(value)
      Base64.encode64(value).chomp
    end

    def encrypt(value)
      if @secret.nil? || (@secret.respond_to?(:size) && @secret.size < 100)
        raise SecretException.new("Secret not set or must have at least 100 characters.")
      else
        encode(cipher(:encrypt, value))
      end
    end

    def self.decrypt(secret, value)
      new(secret).decrypt(value)
    end

    def self.encrypt(secret, value)
      new(secret).encrypt(value)
    end
  end
end
