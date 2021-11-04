module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def count
      @count.nil? ? @count = 0 : @count
    end
    def count=(value)
      @count = value
    end
    def instances
      count
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.count += 1
    end
  end
end