module AttrCipher
  module VERSION
    MAJOR = 1
    MINOR = 0
    TINY  = 0
    PRE   = nil
    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
    SUMMARY = "AttrCipher v#{STRING}"
    DESCRIPTION = "Provides functionality to store encrypted attributes using AES-256-CBC."
  end
end
