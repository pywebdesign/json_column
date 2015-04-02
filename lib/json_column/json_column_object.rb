module JsonColumn
  class JsonColumnObject < HashWithIndifferentAccess

    attr_accessor :_schema
    def initialize
      super
    end
  end
end
