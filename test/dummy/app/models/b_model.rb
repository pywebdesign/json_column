class BModel < ActiveRecord::Base
    acts_as_json_column columns: [{json: :jbson}]
end
