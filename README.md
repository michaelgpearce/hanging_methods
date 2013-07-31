# Hanging Methods - Add a method that you can hang other methods

This is the gem for building nice looking APIs where you want to delegate method calls to another object
at a later time.

See [Parallizer](https://github.com/michaelgpearce/parallizer) for an example.

## Installation

    gem install hanging_methods

## Hanging some methods

Here's an example.

```ruby
require 'rubygems'
require 'hanging_methods'

class Interesting
  include HangingMethods
  
  add_hanging_method :add
end

interesting = Interesting.new
interesting.add.a_method
interesting.add.another_method(1, 2)

puts interesting.hanging_method_invocations(:add)
```


# Credits

[Hanging Methods](https://github.com/michaelgpearce/hanging_methods) is maintained by [Michael Pearce](https://github.com/michaelgpearce)


# Copyright

Copyright (c) 2013 Michael Pearce. See LICENSE.txt for further details.

