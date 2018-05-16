module CustomCipher
  def self.encrypt(secret, value, serialize = false)
    value.to_s.reverse
  end
  def self.decrypt(secret, value, serialize = false)
    value.to_s.reverse
  end
end
