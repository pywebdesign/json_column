#Simple Json column with validation for rails and PostgreSQL Json/Jsonb field

##What is a JsonColumn

JsonColumn is a simple HashWithIndifferentAccess with a ```._schema``` method. It makes it easyer to deal with json, jsonb postgresql column.

* it make properties accessible with ```column[:properties]```` or ```column["properties"]``` interchangly
* it offer a convention on where should the json-schema be placed
* it provide a nice way to integrate json_schema validation, we highly suggest to use [mirego/activerecord_json_validator](https://github.com/mirego/activerecord_json_validator)
* it makes you model looks clean, no special setter, getter and serializer code for every Json columns.

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

# or define asign another schema to a columns
class User < ActiveRecord::Base
  acts_as_json_column columns: [profile: :MyOtherSchema]
end

# It will load the schema file in app/models/schemas/my_other_schema.rb
```

##Usage

Simply use your json column as before. Note that JsonColumn is a HashWithIndifferentAccess so ``` profile["first_name"]``` is identical to ``` profile[:first_name]```.

```ruby

u = User.new
#=>#<User:0x...>

u.profile = {"first_name": "John", last_name: "Snow"}
#=> {:first_name=>"John", :last_name=>"Snow"}

u.save
#=> true

u.reload.profile
#=> {"first_name"=>"John", "last_name"=>"Snow"}

#raise an error when accessign key as a property
u.reload.profile.first_name
#=> RuntimeError: Access the properties first_name with [:first_name]

```

Access the schema easily

```ruby
u.profile._schema
#=> {:type=>"object",
#  :required=>["first_name", "last_name"],
#  :properties=>{:first_name=>{:type=>"string"}, :last_name=>{:type=>"string"}}}
```
##Validations
Validation ca be easily accomplished with [mirego/activerecord_json_validator](https://github.com/mirego/activerecord_json_validator)

```ruby
class User < ActiveRecord::Base
  acts_as_json_column columns: [profile: :UserProfile, ratings: :UserRatings]
  validates :profile, json: { schema: Schemas::UserProfile.schema }
```

##Notes

Your can provide more than one json column to the acts_as_json_column method

```ruby
acts_as_json_column columns: [profile: :UserProfile, ratings: :UserRatings]
```

Makes sure to include all customized schema module names together at the end and automated infered schema module name in front like so

```ruby
acts_as_json_column columns: [:first, :second, profile: :UserProfile, ratings: :UserRatings]
```

##TODO
###Read

* integrate better querry DLS, it would be nice to access properties like activerecord ones!


