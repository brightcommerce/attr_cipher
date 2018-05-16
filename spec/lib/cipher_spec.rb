require 'spec_helper'

describe AttrCipher::Cipher do
  it 'correctly encrypts and decrypts a value given the same secret' do
    secret = SecureRandom.hex(50)

    encrypted = AttrCipher::Cipher.encrypt(secret, "test")
    decrypted = AttrCipher::Cipher.decrypt(secret, encrypted)

    expect("test").not_to eq(encrypted)
    expect("test").to eq(decrypted)
  end

  it "warns that global secret is too short on encryption" do
    AttrCipher.secret = "too_short"
    expect(lambda do
      AttrCipher::Cipher.encrypt(AttrCipher.secret, "test")
    end).to raise_error(AttrCipher::SecretException)
  end

  it "warns that global secret is too short on decryption" do
    AttrCipher.secret = "too_short"
    expect(lambda do
      AttrCipher::Cipher.decrypt(AttrCipher.secret, "SOME_ENCRYPTED_TEXT")
    end).to raise_error(AttrCipher::SecretException)
  end

  it "warns that global secret is not set on encryption" do
    AttrCipher.secret = nil
    expect(lambda do
      AttrCipher::Cipher.encrypt(AttrCipher.secret, "test")
    end).to raise_error(AttrCipher::SecretException)
  end

  it "warns that global secret is not set on decryption" do
    AttrCipher.secret = nil
    expect(lambda do
      AttrCipher::Cipher.decrypt(AttrCipher.secret, "SOME_ENCRYPTED_TEXT")
    end).to raise_error(AttrCipher::SecretException)
  end
end
