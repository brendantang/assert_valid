# AssertValid

A tiny gem that provides that provides two utility methods for testing ActiveRecord models: `assert_valid` and `assert_invalid`.

This gem could easily just be a GitHub gist—the methods are written in less than 50 lines.

But I've copy and pasted them enough times that I just made a gem.

## Installation

Add this gem to your Rails app's development group:

```ruby
group :test do
  # ...
  gem 'assert_valid'
end
```

And then `bundle install`.

Include the module in `test/test_helper.rb`:

```ruby
class ActiveSupport::TestCase
  include AssertValid::Assertions
  # ...
```

Or instead of using the gem, you could just copy the methods as defined in `lib/assert_valid/assertions.rb` and paste them into your `test/test_helper.rb`.


## Usage

In your unit tests, you can use `assert_valid` or `assert_invalid`, passing in the record you want to check.

`assert_invalid` also optionally takes an attribute name to check for an error on that attribute specifically.

If you specify an attribute, you can also specify an error kind. Example:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  validates :name, uniqueness: true
  #...
  
```

```ruby
# test/models/user_test.rb

test "validates unique name" do
  User.create(name: "bob")
  duplicated_user = User.new(name: "bob")
  assert_invalid(duplicated_user, :name, :taken)
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
