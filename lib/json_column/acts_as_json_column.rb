module JsonColumn
  module ActsAsJsonColumn
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_json_column columns:

        columns.each do |col|
          if col.is_a? Symbol
            serialize "#{col}".to_sym, Hash
            schema = "Schemas::#{col.to_s.camelize}".constantize.schema
            cache_name = "cache_attr_#{col}".to_sym
            cattr_accessor cache_name
            define_accessor(col, cache_name, schema)
          elsif col.is_a? Hash
            cols = col
            cols.each do |col, sch|
              serialize "#{col}".to_sym, Hash
              schema = "Schemas::#{sch.to_s.camelize}".constantize.schema
              cache_name = "cache_attr_#{col}".to_sym
              cattr_accessor cache_name
              define_accessor(col, cache_name, schema)
            end
          end
        end
      end

      def define_accessor(col, cache_name, schema)
        define_method(col) do
          if self.send(cache_name)
            self.send(cache_name)
          else
            if schema["type"] == "array"
              obj = JsonColumnArray
            else
              obj = JsonColumnObject
            end
            column = obj[read_attribute(col)]
            column._schema = schema
            self.send("#{cache_name}=", column)
            column
          end
        end

        define_method("#{col}=") do |value|
          if schema["type"] == "array"
            obj = JsonColumnArray
          else
            obj = JsonColumnObject
          end
          column = obj[value]
          column._schema = schema
          self.send("#{cache_name}=", column)
        end
      end

    end
  end
end

ActiveRecord::Base.send :include, JsonColumn::ActsAsJsonColumn