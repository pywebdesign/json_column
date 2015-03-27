module JsonColumn
  class JsonColumn < HashWithIndifferentAccess

    def initialize
      super
    end

    def schema=(sch)
      @schema = sch
      schema[:properties].each do |key, value|
        define_instance_method(key) do
          raise "Access the properties #{key} with [:#{key}]"
        end
      end
    end

    def schema
      @schema || nil
    end

    def define_instance_method(name, &block)
      (class << self; self; end).class_eval do
        define_method name, &block
      end
    end

    def []=(key, value)
      #if valid
      previous_value = self[key]
      regular_writer(convert_key(key),convert_value(value, for: :assignment))
      unless JSON::Validator.validate(schema, self)
        regular_writer(convert_key(key),convert_value(previous_value, for: :assignment))
        raise "Invalid json data for #{key}: #{}; validated with #{schema.class.name}" 
      end
    end

  end
end
