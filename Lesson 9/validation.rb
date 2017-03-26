module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(*attrs)
      @validations ||= []
      @validations << attrs
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.validations
      validations.each do |validation|
        name = validation[0]
        var = instance_variable_get("@#{name}")
        validation_type = validation[1]

        send(validation_type, var, validation[2])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(variable, *)
      raise "#{variable}: аргумент не может быть пустым" if variable.nil? || variable.empty?
    end

    def type(variable, class_check)
      unless variable.is_a? class_check
        raise "#{variable} не является объектом класса #{class_check}"
      end
    end

    def format(variable, _regexp)
      raise "#{variable} не правильного формата" if variable !~ expression
    end
  end
end
