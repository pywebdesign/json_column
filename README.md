#Simple Json column with validation for rails and PostgreSQL Json/Jsonb field

##Installation

Install gem

```
gem install json_column
```
##Setup

JsonColumn use json-schema gem for validation. It will load the schema file form the app/models/schemas

A json profile for a user model could be defined as

```ruby
# app/models/schemas/profile.rb

module Schemas::Profile
  def self.schema
  {
    type: "object",
    required: ["first_name", "last_name"],
    properties: {
      first_name: {type: "string"},
      last_name: {type: "string"}
    }
  }
  end
end
```

Then on the model file, simply add acts_as_json_column

```ruby

# == Schema Information
#
# Table name: users
#
#  id            :uuid             not null, primary key
#  profile       :jsonb
#

class User < ActiveRecord::Base
  acts_as_json_column columns: [:profile]
end
```

##Usage

Simply use your json column as before. Note that JsonColumn is a HashWithIndifferentAccess so ```ruby profile["first_name"]``` is identical to ```ruby profile[:first_name]```.

```ruby

User.first.profile

```

##Customize
You can easily switch to postgis by changing line 8 in fig.yml to:
`image: "pywebdesign/postgis"`

Be sure to also change line 2 in database.setup.yml file to:
`adapter: postgis`

## Notes
If you want to run rake or rails command like `rails generate model cafe...` you must do so in the docker container. Just add docker-compose run web before each command like so:

`docker compose run web rake db:migrate`

### Generated files
generated files wont be yours, just run `. unlock.sh` to get ownership after generating them!
