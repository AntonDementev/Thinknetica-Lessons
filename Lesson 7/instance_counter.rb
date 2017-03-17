module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def begin_count
      self.instances = 1
    end

    def register_new
      self.instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      if self.class.instances
        self.class.register_new
      else
        self.class.begin_count
      end
    end
  end
end
