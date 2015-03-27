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

  end
end
