class ScenarioFavorite < ApplicationRecord
  # アソシエーションの設定-------------------------------------------------
  belongs_to :user
  belongs_to :scenario
  #-----------------------------------------------------------------------
end
