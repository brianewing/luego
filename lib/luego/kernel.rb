require 'luego'

module Kernel
  def future(*args, &block)
    Luego::Future.new(*args, &block)
  end
end
