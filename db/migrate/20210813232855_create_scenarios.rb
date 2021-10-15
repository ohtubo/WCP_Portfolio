class CreateScenarios < ActiveRecord::Migration[5.2]
  def change
    create_table :scenarios do |t|
      t.integer :user_id
      t.string :title
      t.text :overview
      t.string :scenario_image
      t.string :system_category
      t.string :upper_limit_count
      t.string :lower_limit_count
      t.string :play_genre
      t.string :play_time
      t.text :content

      t.timestamps
    end
  end
end
