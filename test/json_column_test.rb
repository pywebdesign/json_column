require 'test_helper'

class JsonColumnTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, JsonColumn
  end

  test "dummy app has a json column and a testmodel AR class" do
    assert TestModel.new.is_a? TestModel
    assert TestModel.new.respond_to? :json
  end

  test "gette for columns provided" do
    assert TestModel.new.respond_to? :json
  end

  test "json column are JsonColumn" do
    assert TestModel.new.json.is_a? JsonColumn::JsonColumn
  end

  test "JsonColumn responds to schema" do
    assert TestModel.new.json.respond_to? :schema
    assert TestModel.new.json.respond_to? :schema=

  end

  test "JsonColumn responds to properties name method" do
    assert TestModel.new.json.respond_to? :a
    refute TestModel.new.json.respond_to? :randomnamemetsa
  end

  test "JsonColumn properties named method are in instance scope and not class method" do
    assert TestModel.new.json.respond_to? :a
    refute BModel.new.json.respond_to? :a
  end

  test "JsonColumn load their schema from infered module" do
    assert TestModel.new.json.schema == Schemas::Json.schema
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
