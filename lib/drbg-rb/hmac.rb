class DRBG::HMAC

  def initialize(entropy, sec_level=256, personalization_string="")
  
    if sec_level > 256
      raise 'sec_level cannot exceed 256 bits'
    end

    if personalization_string.size * 8 > 256
      raise 'personalization_string cannot exceed 256 bits'
    end
    
    if sec_level <= 112
      @security_strength = 112
    elsif sec_level <= 128
      @sec_level = 128
    elsif sec_level <= 192
      @sec_level = 192
    else
      @sec_level = 256
    end

    if (entropy.size * 8 * 2) < (3 * @sec_level)
      raise 'entropy must be at least ' + (1.5 * @sec_level).to_s + ' bits'
    end
  
    if entropy.size * 8 > 1000
      raise 'entropy cannot exceed 1000 bits'
    end
  
    _instantiate(entropy, personalization_string)

  end


  def generate(num_bytes, sec_level=256)
    
    if num_bytes * 8 > 7500
      raise 'generate cannot generate more than 7500 bits in a single call'
    end
    
    if sec_level > @sec_level
      raise 'sec_level exceeds this instance\'s security_strength'
    end
    
    return if @reseed_counter >= 10000

    temp = ''

    while temp.size < num_bytes
      @V = hmac(@K, @V)
      temp += @V
    end

    self._update(nil)
    @reseed_counter += 1

    temp
  
  end

  protected

  def _instantiate(entropy, personalization_string)
  
    seed_material = entropy + personalization_string

    @K = "\x00" * 32
    @V = "\x01" * 32
  
    _update(seed_material)
    @reseed_counter = 1

  end

  def _update(provided_data = nil)
  
    @K = hmac(@K, @V + "\x00" + (provided_data || ''))
    @V = hmac(@K, @V)

    if provided_data
      @K = hmac(@K, @V + "\x01" + provided_data)
      @V = hmac(@K, @V)
    end
  
  end

  def reseed(entropy)
  
    if len(entropy) * 8 < @sec_level
      raise "entropy must be at least #{@sec_level} bits"
    end
  
    if len(entropy) * 8 > 1000
      raise 'entropy cannot exceed 1000 bits'
    end
  
    _update(entropy)
    @reseed_counter = 1

  end

  def hmac(key, data)
    
    @digest ||= OpenSSL::Digest::SHA256.new
    OpenSSL::HMAC.digest(@digest, key, data)
    
  end

end