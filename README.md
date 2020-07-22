# Habakiri

Habariki is a template match engine for strings that can extract part of text by template keywords.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'habakiri'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install habakiri

## Usage

```ruby
require 'habakiri'

template = <<TEMPLATE
YOUR NAME：{{name}}
EMAIL:{{email}}
TELEPHONE NUMBER：{{tel}}
Website URL：{{url}}
ZIP CODE：{{zipcode}}
ADDRESS:{{address}}
NOTE：{{note}}
TEMPLATE

text = <<TEXT
YOUR NAME：John
EMAIL:email@email.com
TELEPHONE NUMBER：+199999999
Website URL：https://example.com/website/url
ZIP CODE：000-0000
ADDRESS:San Francisco, CA 94107 United States
NOTE：
Hello, world!
Hello, ruby!
Hello, habakiri!
TEXT

result = Habakiri.exec(template, text)
pp result
# =>
# {"name"=>"John",
#  "email"=>"email@email.com",
#  "tel"=>"+199999999",
#  "url"=>"https://example.com/website/url",
#  "zipcode"=>"000-0000",
#  "address"=>"San Francisco, CA 94107 United States",
#  "note"=>"Hello, world!\n" + "Hello, ruby!\n" + "Hello, habakiri!"}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/diaphragm/habakiri.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
