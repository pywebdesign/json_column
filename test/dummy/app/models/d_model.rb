class DModel < ActiveRecord::Base


  acts_as_json_column columns: [:arr]
  #validates :arr, json: { schema: Schemas::Arr.schema}

end
