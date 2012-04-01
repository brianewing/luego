require "luego/delegate"
require "thread"

module Luego
  class Future < Delegate
    private :delegate!, :undelegate!, :delegating?

    def initialize(thread = nil, &block)
      @thread = thread || ::Thread.new(&block)
      @thread.run
    end

    def method_missing(*args, &block)
      await!
      super
    end
    
    def await!
      return @child unless @child.nil?

      @child = @thread.value
    end

    def delegating?
      !@thread.alive?
    end

    alias :ready? :delegating?
  end
end
