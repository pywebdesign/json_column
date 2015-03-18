module JsonColumn
  module ActsAsJsonColumn
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_json_column columns:

        columns.each do |col, sch|
          #find the right schema json file module and load the json
          unless sch
            schema = "Schemas::#{col.to_s.camelize}".constantize.schema
          else
            schema = "Schemas::#{sch.to_s.camelize}".constantize.schema
          end

          #define a getter
          temp_field_name = "#{col}_acts_as_json_cache".to_sym
          cattr_accessor temp_field_name

          define_method(col) do
            unless self.send(temp_field_name).is_a? JsonColumn
              Rails.logger.info "creating a JsonColumn"
              json = read_attribute(col)
              if json
                Rails.logger.info "Invalid json data; validated with#{schema.class.name}" unless JSON::Validator.validate(schema, json)
              else
                json = {}
              end
              json_column = JsonColumn[json]
              json_column.schema = schema
              self.send("#{temp_field_name}=", json_column)
            else
              self.send(temp_field_name)
            end
          end

          #define a setter
          define_method("#{col}=") do |data|
            self.send("#{col}_will_change!") unless data == self.send("#{col}")
            if data.is_a? HashWithIndifferentAccess or data.is_a? Hash #why || does not work but or does?
              json_column = JsonColumn[data]
              raise "Invalid json data; validated with #{schema.class.name}" unless JSON::Validator.validate(schema, json_column)
              json_column.schema = schema
              self.send("#{temp_field_name}=", json_column)
              write_attribute(col, json_column)
            elsif data.is_a? JsonColumn
              raise "Invalid json data; validated with #{schema.class.name}" unless JSON::Validator.validate(schema, data)
              data.schema = schema
              self.send("#{temp_field_name}=", data)
              write_attribute(col, data)
            else
               raise "#{col}= takes an Hash or a JsonColumn object"
             end
           end
        end

      end
    end
  end
end

ActiveRecord::Base.send :include, JsonColumn::ActsAsJsonColumn