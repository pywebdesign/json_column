module JsonColumn
  module ActsAsJsonColumn
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_json_column columns:
        columns.each do |c|

          temp_field_name = "#{c}_acts_as_json_temp".to_sym
          cattr_accessor temp_field_name

          #use the temp variable to store a cache of the object
          define_method(c.to_s) do
            unless self.send(temp_field_name).is_a? JsonColumn
              json = read_attribute_before_type_cast(c) || "{}"
              self.send("#{temp_field_name}=", JSON.parse(json, object_class: JsonColumn))
            else
              self.send(temp_field_name)
            end
          end

          define_method("#{c}=") do |data|
            if data.is_a? JsonColumn
              write_attribute(c, data.to_hash)
            elsif data.is_a? Hash
              write_attribute(c, data)
            else
              raise "#{c}= takes an Hash or a JsonColumn object"
            end
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, JsonColumn::ActsAsJsonColumn