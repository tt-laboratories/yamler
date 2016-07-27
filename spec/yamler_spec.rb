require 'yamler'

describe Yamler do
  let(:first_string) { { key: 'admin.foo.bar', value: 'first string' } }
  let(:second_string) { { key: 'admin|foo|bar', value: 'first string' } }
  let(:locale_code) { 'de' }

  let(:resulting_hash) {
    {
      'de' => {
        'admin' => {
          'foo' => {
            'bar' => first_string[:value]
          }
        }
      }
    }
  }

  context :add_string do
    it 'should add locale_code as root if given' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code: locale_code)
      expect(y.to_hash.keys.first).to eq(locale_code)
    end

    it 'should not add locale_code if it is not given' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value])
      expect(y.to_hash.keys.first).to eq('admin')
    end

    it 'should use optional seperator' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], seperator: '|', locale_code: locale_code)
      expect(y.to_hash).to eq(resulting_hash)
    end
  end

  context :to_hash do
    it 'should return a hash' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value])
      expect(y.to_hash).to be_kind_of(Hash)
    end

    it 'should return correct hash' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code: locale_code)
      expect(y.to_hash).to eq(resulting_hash)
    end
  end

  context :to_yaml do
    it 'should return correct yaml' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code: locale_code)
      expect(YAML.load(y.to_yaml)).to eq(resulting_hash)
    end
  end
end
