class CreateCModels < ActiveRecord::Migration
  def change
    create_table :c_models do |t|
      t.jsonb :json
      t.jsonb :jbson

      t.timestamps null: false
    end
  end
end
