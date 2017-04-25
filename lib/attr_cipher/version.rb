module AttrCipher
  module VERSION
    MAJOR = 1
    MINOR = 1
    TINY  = 0
    PRE   = nil
    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
    SUMMARY = "AttrCipher v#{STRING}"
    DESCRIPTION = "Provides to transparently store encrypted attributes in ActiveRecord models."
  end
end
