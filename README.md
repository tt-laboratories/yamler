# YAMLER

Ruby gem to build I18n YAML files

## Installation
### Rails

Add this line to your application's Gemfile:

``` ruby
gem "ocman", :git => 'git@github.com:tt-laboratories/ocman.git'
```

## Usage

### Initialisation

```
y = Yamler.new
```

### Adding a string
Strings can be added by:

```
add_string(<key>, <value>, <options>)
```

The key is a string which contains the list of keys seperated by a seperator (by default '.' by default).

The root element can be set with the options (nil by default).

Example:

```
>> y.add_string('foo.bar.title', 'Hello world')
=> {"foo"=>{"bar"=>{"title"=>"Hello world"}}}
```

Example with optional root element:

```
>> y.add_string('foo.bar.title', 'Hello world', root: 'de')
=> {"de"=>{"foo"=>{"bar"=>{"title"=>"Hello world"}}}}
```

Example with optional seperator:

```
>> y.add_string('foo|bar|title', 'Hello world', seperator: '|')
=> {"foo"=>{"bar"=>{"title"=>"Hello world"}}}
```

### Creating a YAML-file

The current yaml structure can be saved into a yaml-file by:

```
y.to_file(<path>)
```

Example:

```
>> y.to_file('foo.yaml')
=> #<File:foo.yaml (closed)>
```

### Export a Hash
The current strings can be exported as a hash by:

```
>> y.to_hash
=> {"de"=>{"foo"=>{"bar"=>{"title"=>"Hello World"}}}}
```

## Contact
Web: [https://www.toptranslation.com](https://www.toptranslation.com), [https://developer.toptranslation.com](https://developer.toptranslation.com)

Github: [https://www.github.com/tt-laboratories](https://www.github.com/tt-laboratories)

Twitter: [@tt_developers](http://www.twitter.com/tt_developers), [@toptranslation](http://www.twitter.com/toptranslation) 

Mail: tech@toptranslation.com