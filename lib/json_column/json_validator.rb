module ActiveModel
  module Validations
    class JsonValidator < EachValidator
      def validate_each(record, attribute, value)
        errors = JSON::Validator.fully_validate(options[:schema], value)
        if errors
          record.errors[attribute] << (errors)
        end
      end
    end
  end
end
