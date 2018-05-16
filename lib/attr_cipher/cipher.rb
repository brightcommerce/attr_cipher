require 'base64'
require 'digest/sha2'
require 'openssl'

module AttrCipher
  class Cipher
    ALGORITHM = "AES-256-CBC".freeze

    def initialize(secret = nil, serialize = false)
      @secret = secret
      @serialize = serialize
    end

    def cipher(mode, value)
      cipher = OpenSSL::Cipher.new(ALGORITHM).public_send(mode)
      digest = Digest::SHA256.digest(@secret)
      cipher.key = digest
      cipher.iv = digest[0...cipher.iv_len]
      cipher.update(value) + cipher.final
    end

    def decrypt(value)
      if @secret.nil? || (@secret.respond_to?(:size) && @secret.size < 100)
        raise SecretException.new("Secret not set or must have at least 100 characters.")
      else
        decoded = Base64.decode64(value)
        decrypted = cipher(:decrypt, decoded)
        @serialize ? Marshal.load(decrypted) : decrypted
      end
    end

    def encrypt(value)
      if @secret.nil? || (@secret.respond_to?(:size) && @secret.size < 100)
        raise SecretException.new("Secret not set or must have at least 100 characters.")
      else
        data = @serialize ? Marshal.dump(value) : value.to_s
        encrypted = cipher(:encrypt, data)
        Base64.encode64(encrypted).chomp
      end
    end

    def self.decrypt(secret, value, serialize = false)
      new(secret, serialize).decrypt(value)
    end

    def self.encrypt(secret, value, serialize = false)
      new(secret, serialize).encrypt(value)
    end
  end
end
