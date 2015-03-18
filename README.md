#Simple Json column with validation for rails and PostgreSQL Json/Jsonb field

##Goal
This gem aim to replace the simple Hash representation with a more useful representation object for json colums. Right now it is pretty much only another way to implement json-schema validation.

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

u = User.new
#=>#<User:0x...>

u.profile = {"first_name": "John", last_name: "Snow"}
#=> {:first_name=>"John", :last_name=>"Snow"}

u.save
#=> true

u.reload.profile
#=> {"first_name"=>"John", "last_name"=>"Snow"}

```

Access the schema easily

```ruby
u.profile.schema
#=> {:type=>"object",
#  :required=>["first_name", "last_name"],
#  :properties=>{:first_name=>{:type=>"string"}, :last_name=>{:type=>"string"}}}
```

##Notes

Your can provide more than one json column to the acts_as_json_column method

```ruby
acts_as_json_column columns: [:first_column_name, :second_column_name]
```
