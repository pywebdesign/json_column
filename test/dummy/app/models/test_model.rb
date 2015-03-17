class TestModel < ActiveRecord::Base
  
  acts_as_json_column columns: [:test]
end
