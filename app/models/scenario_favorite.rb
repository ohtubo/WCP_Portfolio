class ScenarioFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :scenario
end