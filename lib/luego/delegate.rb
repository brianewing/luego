module Luego
  class Delegate < BasicObject
    def initialize(object)
      @child = object
    end

    def send(*args, &block)
      return super unless delegating?
      @child.send *args, &block
    end

    def method_missing(*args, &block)
      return super unless delegating?
      send *args, &block
    end

    def delegating?
      !!@delegating
    end

    def delegate!
      @delegating = true
    end

    def undelegate!
      @delegating = false
    end

    BasicObject.instance_methods.each do |m|
      next if m.to_s.start_with? '__'

      undef_method m
    end
  end
end
