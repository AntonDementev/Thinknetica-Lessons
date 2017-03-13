module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    
    def instances
      @@count
    end
      
    def register_new
      @@count += 1
    end
     
end
  
  module InstanceMethods
  
    protected
  
    def register_instance
      self.class.register_new
    end
    
  end
  
end
