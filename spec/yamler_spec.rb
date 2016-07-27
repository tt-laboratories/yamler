require 'rails_helper'

describe Yamler do
  let(:first_string) { { key: 'admin.foo.bar', value: 'first string' } }
  let(:second_string) { { key: 'admin.bar.foo', value: 'second string' } }
  let(:locale_code) { 'de' }

  let(:first_resulting_hash) {
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
    it 'should add locale_code as root' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code)
      expect(y.to_hash.keys.first).to eq(locale_code)
    end
  end

  context :to_hash do
    it 'should return a hash' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code)
      expect(y.to_hash).to be_kind_of(Hash)
    end

    it 'should return correct hash' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code)
      expect(y.to_hash).to eq(first_resulting_hash)
    end
  end

  context :to_yaml do
    it 'should return correct yaml' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code)
      expect(YAML.load(y.to_yaml)).to eq(first_resulting_hash)
    end
  end

  context :to_file do
    let(:path) { 'foobar.yml' }

    it 'should call File.open' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code)
      expect(File).to receive('open').with(path, 'w').and_return(true)
      y.to_file(path)
    end
  end
end
