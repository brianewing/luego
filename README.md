Luego ![Build status](https://secure.travis-ci.org/brianewing/luego.png?branch=master)
=====

A simple gem to bring the wonder of Io Futures to Ruby.

Usage
-----

```ruby
thing = "hello!"

string = Luego::Future.new do
  sleep 5
  thing
end

string.upcase! # 5 seconds pass, then => "HELLO!"
string === thing # true

future = Luego::Future.new &some_block
future.ready? # => false until the block, in a new thread, returns

future.await! # => return value of the block, waits for the thread to join
```

But wait, there's more!
--

Luego also provides `Luego::Delegate`, which is a 100% transparent proxy for objects, toggleable with `delegate!` and `undelegate!` instance methods.

This is how Luego::Future 'becomes' the object as in Io - it simply starts delegating.

See the [specs](http://github.com/brianewing/luego/tree/master/spec/delegate_spec.rb) for an idea of how transparent the delegation is.

Running the tests
-----------------

Clone the repository, `bundle`, `rspec spec`.
You should see greens greener than green grass from Greenland.

Contributing
------------

1. Fork, branch, work, commit
2. Submit a pull request
3. ???
4. Profit!