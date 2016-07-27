class Yamler
  def initialize
    @hash = {}
  end

  def add_string(key, value, locale_code, options={})
    seperator = options['seperator'] || '.'
    keys = key.split(seperator).unshift(locale_code)
    @hash = add_to_hash(keys, value)
  end

  def to_hash
    @hash
  end

  def to_yaml
    @hash.to_yaml
  end

  def to_file(path)
    File.open(path, 'w') { |file| file.write to_yaml }
  end

  private
    def add_to_hash(keys, value, hash=nil)
      hash ||= @hash
      result = hash.clone
      first_key = keys.first
      keys.shift

      if result.has_key?(first_key)
        result[first_key] = add_to_hash(keys, value, result[first_key])
      else
        if keys.empty?
          result[first_key] = value
        else
          new_hash = Hash.new
          new_hash[first_key] = Hash.new

          result[first_key] = add_to_hash(keys, value, new_hash[first_key])
        end
      end

      result
    end
end
