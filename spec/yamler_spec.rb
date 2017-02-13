require 'yamler'

describe Yamler do
  let(:first_string) { { key: 'admin.foo.bar', value: 'first string' } }
  let(:second_string) { { key: 'admin.foo.bar', value: 'second string' } }
  let(:third_string) { { key: 'admin.foo.bar2', value: 'third string' } }
  let(:fourth_string) { { key: 'admin.foo.bar3', value: 'fourth string' } }
  let(:fifth_string) { { key: 'admin.foo2', value: 'fifth string' } }
  let(:sixth_string) { { key: 'admin.foo3', value: 'sixth string' } }
  let(:optional_separator_string) { { key: 'admin|foo|bar', value: 'first string' } }
  let(:locale_code) { 'de' }

  let(:resulting_hash) {
    {
      'de' => {
        'admin' => {
          'foo' => {
            'bar' => ['second string', 'first string'],
            'bar2' => ['third string'],
            'bar3' => 'fourth string'
          },
          'foo2' => 'fifth string',
          'foo3' => ['sixth string']
        }
      }
    }
  }

  context :add_string do
    it 'should add locale_code as root if given' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code: locale_code, array_index: 1)
      y.add_string(second_string[:key], second_string[:value], locale_code: locale_code, array_index: 0)
      y.add_string(third_string[:key], third_string[:value], locale_code: locale_code, array_index: 0)
      y.add_string(fourth_string[:key], fourth_string[:value], locale_code: locale_code)
      y.add_string(fifth_string[:key], fifth_string[:value], locale_code: locale_code)
      y.add_string(sixth_string[:key], sixth_string[:value], locale_code: locale_code, array_index: 0)
      expect(y.to_hash.keys.first).to eq(locale_code)
    end

    it 'should not add locale_code if it is not given' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value])
      expect(y.to_hash.keys.first).to eq('admin')
    end

    it 'should use optional seperator' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], separator: '|', locale_code: locale_code, array_index: 1)
      y.add_string(second_string[:key], second_string[:value], separator: '|', locale_code: locale_code, array_index: 0)
      y.add_string(third_string[:key], third_string[:value], separator: '|', locale_code: locale_code, array_index: 0)
      y.add_string(fourth_string[:key], fourth_string[:value], separator: '|', locale_code: locale_code)
      y.add_string(fifth_string[:key], fifth_string[:value], separator: '|', locale_code: locale_code)
      y.add_string(sixth_string[:key], sixth_string[:value], separator: '|', locale_code: locale_code, array_index: 0)
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
      y.add_string(first_string[:key], first_string[:value], locale_code: locale_code, array_index: 1)
      y.add_string(second_string[:key], second_string[:value], locale_code: locale_code, array_index: 0)
      y.add_string(third_string[:key], third_string[:value], locale_code: locale_code, array_index: 0)
      y.add_string(fourth_string[:key], fourth_string[:value], locale_code: locale_code)
      y.add_string(fifth_string[:key], fifth_string[:value], locale_code: locale_code)
      y.add_string(sixth_string[:key], sixth_string[:value], locale_code: locale_code, array_index: 0)
      expect(y.to_hash).to eq(resulting_hash)
    end
  end

  context :to_yaml do
    it 'should return correct yaml' do
      y = Yamler.new
      y.add_string(first_string[:key], first_string[:value], locale_code: locale_code, array_index: 1)
      y.add_string(second_string[:key], second_string[:value], locale_code: locale_code, array_index: 0)
      y.add_string(third_string[:key], third_string[:value], locale_code: locale_code, array_index: 0)
      y.add_string(fourth_string[:key], fourth_string[:value], locale_code: locale_code)
      y.add_string(fifth_string[:key], fifth_string[:value], locale_code: locale_code)
      y.add_string(sixth_string[:key], sixth_string[:value], locale_code: locale_code, array_index: 0)
      expect(YAML.load(y.to_yaml)).to eq(resulting_hash)
    end
  end
end
