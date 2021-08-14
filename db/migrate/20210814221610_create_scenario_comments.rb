class CreateScenarioComments < ActiveRecord::Migration[5.2]
  def change
    create_table :scenario_comments do |t|
      t.integer :scenario_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
