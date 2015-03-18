module Schemas::Json
  def self.schema
    {
      type: "object",
      required: ["a"],
      properties: {
        a: {type: "integer"}
      }
    }
  end
end