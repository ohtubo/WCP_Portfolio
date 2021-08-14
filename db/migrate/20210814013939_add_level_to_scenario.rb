class AddLevelToScenario < ActiveRecord::Migration[5.2]
  def change
    add_column :scenarios, :level, :string
  end
end
