class CreateDModels < ActiveRecord::Migration
  def change
    create_table :d_models do |t|
      t.jsonb :arr

      t.timestamps null: false
    end
  end
end
