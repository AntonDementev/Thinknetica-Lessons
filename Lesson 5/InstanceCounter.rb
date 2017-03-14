module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def begin_count
      self.count = 0
    end
    
    def instances
      self.count
    end
      
    def register_new
      self.count += 1
    end
    
    attr_accessor :count
     
end
  
  module InstanceMethods
  
    protected
  
    def register_instance
      self.class.register_new
    end
    
  end
  
end
