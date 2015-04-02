class DModel < ActiveRecord::Base
  acts_as_json_column columns: [:arr]
end
