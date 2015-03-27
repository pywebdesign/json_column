module Schemas::Jbson
  def self.schema
    {
      type: "object",
      required: ["b"],
      properties: {
        b: {type: "integer"}
      }
    }
  end
end