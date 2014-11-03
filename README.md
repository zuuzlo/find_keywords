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

You can now add a custom list of removal words using the class RemoveWordsList.
```ruby
industry_specific_words= FindKeywords::RemoveWordsList.new(%w(free shipping members for))
sentence = "free shipping For women members"
keywords = FindKeywords::Keywords.new(sentence, industry_specific_words).keywords
keywords => ["women"]
```
Three option use the specifice list as shown above. 

Use both costum list and stop word list by add "all".

```ruby
TODO:
industry_specific_words= FindKeywords::RemoveWordsList.new(%w(free shipping members for))
sentence = "free shipping For women members"
keywords = FindKeywords::Keywords.new(sentence, "all").keywords
keywords => ["women"]
```

```ruby
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
