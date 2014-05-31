# FindKeywords

Finds keywords in a sentence.  Uses a stop word list and market word list to remove words that are not relevent.

## Installation

Add this line to your application's Gemfile:

    gem 'find_keywords'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install find_keywords

## Usage

Find keywords is used to take a string (sentence), list (array), or a hash and return only keyword.  It removes the stop words and list of other words.

ruby```
sentence = "_the yellow__jeans_"
keywords = FindKeywords::Keywords.new(sentence).keywords
keywords => ["yellow", "jeans"]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/find_keywords/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
