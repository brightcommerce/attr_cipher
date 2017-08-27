ActiveRecord::Schema.define do
  self.verbose = false

  create_table :model_with_cipher, force: true do |t|
    t.text :api_key_cipher
  end

  create_table :model_with_ciphers, force: true do |t|
    t.text :api_key_cipher
    t.text :security_answer_cipher
    t.text :knowledge_cipher
  end
end
