module JsonColumn
  class JsonColumnArray < Array

    attr_accessor :_schema
    def initialize
      super
    end
  end
end
