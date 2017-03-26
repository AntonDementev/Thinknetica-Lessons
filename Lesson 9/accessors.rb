module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      array_name = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        array = instance_variable_get(array_name)
        var   = instance_variable_get(var_name)

        instance_variable_set(var_name, value)

        if array.nil?
          instance_variable_set(array_name, [var, value])
        else
          array << value
        end
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(array_name) }
    end
  end

  def strong_attr_acessor(name, attr_class)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      if value.is_a? attr_class
        instance_variable_set(var_name, value)
      else
        raise "#{name} присваивается значение неправильного класса"
      end
    end
  end
end
