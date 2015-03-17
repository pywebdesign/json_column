require 'test_helper'

class JsonColumnTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, JsonColumn
  end

  test "create getter and setter for columns provided" do
    assert TestModel.new.respond_to? :test
    assert TestModel.new.respond_to? :test=
  end

  test "column set as jsoncolumn are JsonColumn" do
    assert TestModel.new.test.is_a? JsonColumn::JsonColumn
  end
end
