class DModel < ActiveRecord::Base
  acts_as_json_column columns: [:arr]
  validates :arr, json: { schema: Schemas::Arr.schema.to_json}
  # => ArgumentError: Unknown validator: 'JsonValidator'
  # => from /app/vendor/bundle/gems/activemodel-4.2.1/lib/active_model/validations/validates.rb:120:in `rescue in block in validates'
  # => [4] pry(main)> exit

end
