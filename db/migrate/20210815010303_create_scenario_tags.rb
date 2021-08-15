class CreateScenarioTags < ActiveRecord::Migration[5.2]
  def change
    create_table :scenario_tags do |t|
      t.integer :scenario_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
