# OpenStructFactory

A factory to create `OpenStruct` objects from nested hashes and arrays.

The main difference with other gems such as [recursive-open-struct](https://github.com/aetherknight/recursive-open-struct) is that this library is entirely decoupled: it doesn't inherit from `OpenStruct` and doesn't rely on any core extensions.

## Installation

Add this line to your application's Gemfile:

    gem 'open_struct_factory'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open_struct_factory

## Usage

```ruby

require 'ostruct'
require 'open_struct_factory'

book_data = {
  title: "The World as Will and Representation",
  author: {
    name: "Arthur Schopenhauer",
    birth_date: "1788-02-22",
    birth_place: "Danzig",
  },
  publications: [
    {edition: "1st edition", year: 1818},
    {edition: "2nd expanded edition", year: 1844},
  ]
}

book = OpenStructFactory.create(book_data)

puts book.title
# => The World as Will and Representation

puts book.author.name
# => Arthur Schopenhauer

puts book.publications[1].year
# => 1844

```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/open_struct_factory/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
