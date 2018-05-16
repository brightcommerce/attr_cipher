# Change Log

##v1.5.0
- Created `AttrCipher::SecretException` class.
- Updated FactoryGirl to FactoryBot (dev dependency).
- Updated Codecov to ~> 0.16.1 (dev dependency).
- Added Ruby 2.4.4 to Travis CI config.
- Switched serialize option to use Marshal instead of YAML.
- Refactored cipher.

##v1.4.0
- Added serialize option to `attr_cipher` class method. Can now seamlessly handle value types other than just strings.

##v1.3.1
- Fixed failing spec.

##v1.3.0
- Loosened ActiveRecord version to >= 4.2.6 only.
- Loosened ActiveSupport version to >= 4.2.6 only.
- Moved secret length validator to encrypt and decrypt functions of Cipher module to remove false positive warnings at startup.
- Updated specs with changes.

##v1.2.0
- Updated README.
- Updated Gem description.

##v1.1.0
- Updated Gem description.

##v1.0.0
- Initial release.
