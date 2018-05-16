FactoryBot.define do
  factory :model_with_cipher do
    api_key 'APIKEY1'
  end

  factory :model_with_ciphers do
    api_key 'APIKEY2'
    security_answer 'ANSWER'
  end

  factory :model_with_custom_cipher_option do
    api_key 'APIKEY3'
  end

  factory :model_with_custom_secret_option do
    api_key 'APIKEY4'
  end

  factory :model_with_serialize_option do
    knowledge KNOWLEDGE
  end
end
