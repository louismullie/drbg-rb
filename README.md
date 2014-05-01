##drbg-rb

This gem implements cryptographically secure deterministic random bit generators for Ruby. Currently, the gem supports HMAC_DRBG as described in NIST SP 800-90A.

###Warning

_If you are looking for a generic Ruby CSRPNG, this is probably not what you are looking for. Instead, use [SecureRandom](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/securerandom/rdoc/SecureRandom.html). Only use this library if you absolutely need a random number generator that is explicitly seedable. If you don't know what this means, **do not** use this library._

###Install

    gem install drbg-rb

###Usage

```ruby
require 'drbg-rb'

rng = DRBG::HMAC.new(entropy)
bytes = rng.generate(10)
```

###Reference

- [NIST SP 800-90](http://csrc.nist.gov/groups/STM/cavp/documents/drbg/DRBGVS.pdf) - Deterministic Random Bit Generator Validation System

###License

This program is released under the BSD license.