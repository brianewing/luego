Luego ![Build status](https://secure.travis-ci.org/brianewing/luego.png?branch=master)
=====

Futures are objects which allow you to pass around the result of an asynchronous operation as if it had returned immediately.

You pass a block to run in a new thread, and you'll get back an object which will delegate completely to the value returned from the thread.

If you try and call any methods before the thread has returned, it will block until the thread has returned before sending the message along.

Luego takes care to make the delegation 100% transparent, without even methods from BasicObject.

```ruby
value = future { API.slow_method(timeout: 10.seconds) }
```

You can pass `value` around and your app can get on with doing its thing until the result is actually needed or used.

You could use futures for things like IO, passing the result around without having to block upfront or pass knowledge of the asynchronicity down the stack.

Usage
-----

```ruby
require 'luego/kernel' # defines methods in Kernel

msg = "hello!"

result = future do
  sleep 5
  msg
end

result.upcase! # 5 seconds pass, then "HELLO!" is returned
result === msg # true

result = future &some_block

result.ready? # returns false until the block, run in a new thread, returns
result.await! # joins the thread, returns the value
```

But wait, there's more!
--

Luego also provides `Luego::Delegate`, an object which proxies completely to another, with even methods from BasicObject delegated for complete transparency.

It can be toggled on and off with `#delegate!` and `#undelegate!`.

This is how Luego::Future 'becomes' the object like in Io - it simply starts delegating.

See the [specs](http://github.com/brianewing/luego/tree/master/spec/delegate_spec.rb).

Running the tests
-----------------

Clone the repository, `bundle`, `rspec spec`.

Contributing
------------

1. Fork, branch, work, commit
2. Submit a pull request
3. ???
4. Profit!
