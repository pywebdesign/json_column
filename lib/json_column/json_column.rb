module JsonColumn
  class JsonColumn < HashWithIndifferentAccess

    attr_accessor :_schema
    def initialize
      super
    end
  end
end
