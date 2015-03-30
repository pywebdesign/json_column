class CModel < ActiveRecord::Base
  acts_as_json_column columns: [{json: :json}, {jbson: :jbson}]
end
