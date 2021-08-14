class RenameScenarioImageColumnToScenarios < ActiveRecord::Migration[5.2]
  def change
    rename_column :Scenarios, :scenario_image, :scenario_image_id
  end
end
