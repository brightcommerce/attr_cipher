CUSTOM_SECRET = SecureRandom.hex(50).freeze
SECRET = SecureRandom.hex(50).freeze
AttrCipher.secret = SECRET
KNOWLEDGE = {:question => 'third primary pseudoperfect number', :answer => 42}

class ModelWithCipher < ActiveRecord::Base
  attr_cipher :api_key
end

class ModelWithCiphers < ActiveRecord::Base
  attr_cipher :api_key, :security_answer
end

class ModelWithCustomCipherOption < ActiveRecord::Base
  self.table_name = "model_with_cipher"
  attr_cipher :api_key, cipher: CustomCipher
end

class ModelWithCustomSecretOption < ActiveRecord::Base
  self.table_name = "model_with_cipher"
  attr_cipher :api_key, secret: CUSTOM_SECRET
end

class ModelWithSerializeOption < ActiveRecord::Base
  self.table_name = "model_with_ciphers"
  attr_cipher :knowledge, serialize: true
end
