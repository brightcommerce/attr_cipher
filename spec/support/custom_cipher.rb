module CustomCipher
  def self.encrypt(secret, value)
    value.to_s.reverse
  end
  def self.decrypt(secret, value)
    value.to_s.reverse
  end
end
