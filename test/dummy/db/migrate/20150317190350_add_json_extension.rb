class AddJsonExtension < ActiveRecord::Migration
  def change
    add_column :test_models, :json, :jsonb
  end
end
