module AttrCipher
  module VERSION
    MAJOR = 1
    MINOR = 3
    TINY  = 0
    PRE   = nil
    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
    SUMMARY = "AttrCipher v#{STRING}"
    DESCRIPTION = "Provides functionality to transparently store and retrieve encrypted attributes in ActiveRecord models."
  end
end
