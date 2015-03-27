class CreateBModels < ActiveRecord::Migration
  def change
    create_table :b_models do |t|
      t.jsonb :json

      t.timestamps null: false
    end
  end
end
