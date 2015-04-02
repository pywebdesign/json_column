require 'test_helper'

class JsonColumnTest < ActiveSupport::TestCase
  test "it loads Schemas as Yml/yaml file" do
    assert Schemas::Json.is_a? Module
  end

  test "it loads Schemas as json file" do
    assert Schemas::Jbson.is_a? Module
  end

  test "it raise an error when schema file does not exist" do
    assert_raise RuntimeError do
      Schemas::Jsonsdas
    end
  end

  test "dummy app has a json column and a testmodel AR class" do
    assert TestModel.new.is_a? TestModel
    assert TestModel.new.respond_to? :json
  end

  test "gette for columns provided" do
    assert TestModel.new.respond_to? :json
  end

  test "JsonColumn load their schema from infered module" do
    assert TestModel.new.json._schema == Schemas::Json.schema
  end

  test "JsonColumn properties named method are in instance scope and not class method" do
    assert TestModel.new.json.respond_to? :a
    refute BModel.new.json.respond_to? :a
  end

  test "JsonColumn can receive Hash to change but stay of type JsonColumn" do
    t = TestModel.new
    t.json = {a: 42}
    assert t.json.is_a? JsonColumn::JsonColumn
  end

  test "Jsoncolumn change are saved to database" do
    t = TestModel.new
    t.json = {a: 42}
    t.save
    assert t.reload.json.to_s == HashWithIndifferentAccess[{"a": 42}].to_s
  end
end
