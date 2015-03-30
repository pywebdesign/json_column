require 'json-schema'
require 'json_column/json_column'
require 'json_column/acts_as_json_column'
module JsonColumn
  # class Railtie < ::Rails::Railtie
  #   initializer 'activeservice.autoload', :before => :set_autoload_paths do |app|
  #     app.config.autoload_paths << Rails.root.join('app', 'models', 'schemas')
  #   end
  # end
end


module Schemas
  def self.const_missing(name)
    self.const_set(name, self.load_schema_file(name))
  end

  def self.load_schema_file(name)
    file = Dir["#{Rails.root}/app/models/schemas/#{name.to_s.underscore}*"].select {|f| f =~ /.*.(json|ya?ml)\z/ }
    if file.blank?
      raise "no such schema defined: #{name}"
    end
    sch = YAML.load_file(file[0]).with_indifferent_access

    # if we did find the schema file we create a module
    # with the schema accessible in the schema method
    # this looks like if the yml file is in fact a ruby
    # module.
    Module.new do
      @schema = sch
      def self.schema
        @schema
      end
    end
  end
end


## we could preload schema file in cache by looping and invoking all Schemas::(constant)