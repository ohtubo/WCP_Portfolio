class CreateScenarioFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :scenario_favorites do |t|
      t.integer :scenario_id
      t.integer :user_id

      t.timestamps
    end
  end
end
