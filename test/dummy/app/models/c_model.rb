class CModel < ActiveRecord::Base

  acts_as_json_column columns: [:json, jbson: :jbson]
end
