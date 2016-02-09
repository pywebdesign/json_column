#JsonColumn
A simple Json column with validation for rails and PostgreSQL Json/Jsonb field

##What is a JsonColumn

JsonColumn is a simple HashWithIndifferentAccess with a ```._schema``` method. It makes it easier to deal with json, jsonb postgresql column.

* It make properties accessible with ```column[:properties]``` or ```column["properties"]``` interchangeably
* It offer a convention on where should the json-schema be placed, soon will also be changeable in config
* It provide a nice way to integrate json_schema validatin.
* It makes you model looks clean, no special setter, getter and serializer code for every Json columns.

##Installation

Install gem

```
gem install json_column
```
##Setup

It will load the schema file from the app/models/schemas. We decided not to put the file in /db/schema because it is not a database setup script in any way. We would like your opinion on where the json schema file should beé

A json profile schema for a user model could be defined as

```json
  {
    "type": "object",
    "required": ["first_name", "last_name"],
    "properties": {
      "first_name": {"type": "string"},
      "last_name": {"type": "string"}
    }
  }

```
and put in **app/models/schemas/profile.json**

or as a Yaml, which looks cleaner

```yaml
    type: "object"
    required: 
      - "first_name"
      - "last_name"
    properties:
      first_name: 
        type: "string"
      last_name: 
        type: "string"
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
# It will load the schema file in app/models/schemas/profile.rb

# or define another schema to a columns
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

```

Access the schema easily, everywhere

```ruby
u.profile._schema
#=> {:type=>"object",
#  :required=>["first_name", "last_name"],
#  :properties=>{:first_name=>{:type=>"string"}, :last_name=>{:type=>"string"}}}
```
##Validations
Validation can be easily accomplished with the same syntax as [mirego/activerecord_json_validator](https://github.com/mirego/activerecord_json_validator). We decided not to use mirego's gem finally since it is overly complicated for the task. 

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

Makes sure to include all customized schema module names column together at the end and automatically inferred schema module name column in front like so. Otherwise you will need to puts {} around each element from the passed array.

```ruby
acts_as_json_column columns: [:first, :second, profile: :UserProfile, ratings: :UserRatings]

# or if you really want:

acts_as_json_column columns: [:first,  {profile: :UserProfile}, :second, {ratings: :UserRatings}]
```

##TODO
* integrate better querry DLS, it would be nice to access properties like activerecord ones! Maybe use Hashies gem or store_accessor
