require 'yaml'

class Yamler
  def initialize
    @hash = {}
  end

  def add_string(key, value, options={})
    seperator = options[:seperator] || '.'
    keys = key.split(seperator)
    keys.unshift(options[:locale_code]) if options[:locale_code]
    @hash = add_to_hash(keys, value, options[:array_index])
  end

  def to_hash
    @hash
  end

  def to_yaml
    @hash.to_yaml
  end

  def to_file(path)
    file = File.open(path, 'w')
    file.write self.to_yaml
    file
  ensure
    file.close
  end

  private
  def add_to_hash(keys, value, array_index=nil, hash=nil)
    hash ||= @hash
    result = hash.clone
    first_key = keys.first
    keys.shift
    if result.has_key?(first_key) && result[first_key].instance_of?(Hash)
      result[first_key] = add_to_hash(keys, value, array_index, result[first_key])
    else
      if keys.empty?
        if array_index
          if result.has_key?(first_key)
             result[first_key][array_index] = value
          else
            result[first_key] = [].insert(array_index, value)
          end
        else
          result[first_key] = value
        end
      else
        new_hash = Hash.new
        new_hash[first_key] = Hash.new
        result[first_key] = add_to_hash(keys, value, array_index, new_hash[first_key])
      end
    end
    result
  end
end
