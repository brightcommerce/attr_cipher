require 'spec_helper'

describe AttrCipher::Cipher do
  it 'correctly encrypts and decrypts a value given the same secret' do
    secret = SecureRandom.hex(50)

    encrypted = AttrCipher::Cipher.encrypt(secret, "test")
    decrypted = AttrCipher::Cipher.decrypt(secret, encrypted)

    expect("test").not_to eq(encrypted)
    expect("test").to eq(decrypted)
  end
end
