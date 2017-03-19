module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(*attrs)
      attr_name = attrs[0]
      attr_type = attrs[1]

      case attr_type
      when :presence
        return attr_name
      when :format
        return attr_name =~ attrs[2]
      when :type
        return attr_name.is_a? attrs[2]
      end
    end
  end

  module InstanceMethods
    def validate!(name, regexp, class_check)
      raise 'Валидация presence не прошла' unless self.class.validate(name, :presence)
      raise 'Валидация type не прошла' unless self.class.validate(name, :type, class_check)
      raise 'Валидация format не прошла' unless self.class.validate(name, :format, regexp)
    end

    def valid?(name, regexp, class_check)
      !!(self.class.validate(name, :presence) && self.class.validate(name, :format, regexp) && self.class.validate(name, :type, class_check))
    end
  end
end
