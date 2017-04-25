require 'spec_helper'

describe ModelWithCipher do
  before do
    $stderr = StringIO.new
  end

  after(:all) do
    $stderr = STDERR
  end

  it 'responds to :api_key' do
    respond_to(:api_key)
  end

  it 'responds to :api_key=' do
    respond_to(:api_key=)
  end

  it 'includes AttrCipher module to ActiveRecord' do
    expect(ActiveRecord::Base.included_modules).to include(AttrCipher)
  end

  it "warns that global secret is too short" do
    line_number = __LINE__ + 6
    expected_message = [
      "[attr_cipher] secret must have at least 100 characters",
      "(called from #{__FILE__}:%d)\n"
    ].join(" ")
    expected_output = expected_message % line_number
    AttrCipher.secret = "short"
    expect($stderr.string).to match(expected_output)
  end

  it 'correctly stores and retrieves the secret' do
    SECRET = SecureRandom.hex(50)
    AttrCipher.secret = SECRET
    expect(AttrCipher.secret).to eq(SECRET)
  end

  it 'encrypts and decrypts the api_key attribute' do
    model = FactoryGirl.create(:model_with_cipher)
    AttrCipher.secret = SecureRandom.hex(50)
    expect(model.api_key).to eq('APIKEY1')
  end
end

describe ModelWithCiphers do
  AttrCipher.secret = SecureRandom.hex(50)

  it 'responds to :api_key' do
    respond_to(:api_key)
  end

  it 'responds to :api_key=' do
    respond_to(:api_key=)
  end

  it 'responds to :secret_answer' do
    respond_to(:secret_answer)
  end

  it 'responds to :secret_answer=' do
    respond_to(:secret_answer=)
  end
end

describe ModelWithCustomCipherOption do
  AttrCipher.secret = SecureRandom.hex(50)
  it 'sets the custom cipher option correctly' do
    model = FactoryGirl.create(:model_with_custom_cipher_option)
    expect(model.api_key_cipher).to eq('APIKEY3'.reverse)
    expect(model.api_key).to eq('APIKEY3')
    custom_secret = SecureRandom.hex(50)
    olleh = CustomCipher.encrypt(custom_secret, 'hello')
    expect(olleh).to eq('hello'.reverse)
    hello = CustomCipher.decrypt(custom_secret, olleh)
    expect(hello).to eq('hello')
  end
end

describe ModelWithCustomSecretOption do
  AttrCipher.secret = SecureRandom.hex(50)
  it 'sets the custom secret option correctly' do
    encrypted_api_key = AttrCipher::Cipher.encrypt(CUSTOM_SECRET, "APIKEY4")
    model = FactoryGirl.create(:model_with_custom_secret_option)
    expect(model.api_key_cipher).to eq(encrypted_api_key)
  end
end
