Luego ![Build status](https://secure.travis-ci.org/brianewing/luego.png?branch=master)
=====

A simple gem to bring the wonder of Io Futures to Ruby.

Futures are objects, created with a(n expensive) block, that can be passed around freely and only block at the point that they're used.

```ruby
thing = future { fetch_thing_from_slow_api }
```

`thing` is now just an object that can be passed around. It will 'become' the result as soon as it's used, or your block returns - whichever comes first.

In practice, you could use futures for things like IO, while passing it around like it's the end result you want.
**The rest of your stack can get on with doing its thing until the result is actually needed/used.**

Usage
-----

```ruby
require 'luego/kernel'
thing = "hello!"

string = future do
  sleep 5
  thing
end

string.upcase! # 5 seconds pass, then => "HELLO!"
string === thing # true

aye = future &some_block
aye.ready? # => false until the block, in a new thread, returns

aye.await! # => return value of the block, waits for the thread to join
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