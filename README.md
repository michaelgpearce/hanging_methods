# Hanging Methods - Add a method that you can hang other methods

This is the gem for building nice looking APIs where you want to delegate method calls to another object
at a later time.

See [Parallizer](https://github.com/michaelgpearce/parallizer) for an example.

## Installation

    gem install hanging_methods

## Hanging some methods

Here's an example.

```ruby
require 'hanging_methods'

class Interesting
  include HangingMethods

  add_hanging_method :add
end

interesting = Interesting.new
interesting.add.a_method
interesting.add.another_method(1, 2)

puts interesting.hanging_method_invocations(:add)
# [[:a_method], [:another_method, 1, 2]]
```


## Get notified of a hanging method

You can be notified of method being hanged and specify its result.

```ruby
require 'hanging_methods'

class Interesting
  include HangingMethods

  add_hanging_method :add, after_invocation: :added

  private

  def added(method_name, arg_1, arg_2, &block)
    return "very_interesting: #{arg_1}, #{arg_2}, #{yield}"
  end
end

interesting = Interesting.new
interesting.add.a_method(1, 2) { 3 }
# returns "very_interesting: 1, 2, 3"
```

# Credits

[Hanging Methods](https://github.com/michaelgpearce/hanging_methods) is maintained by [Michael Pearce](https://github.com/michaelgpearce)


# Copyright

Copyright (c) 2013 Michael Pearce. See LICENSE.txt for further details.

