class ScenarioComment < ApplicationRecord
  # アソシエーションの設定-------------------------------------------------
  belongs_to :user
  belongs_to :scenario
  #-----------------------------------------------------------------------

  # バリデーションの設定---------------------------------------------------
  # presence: true(空白禁止) , length: { maximum: n }(n+1文字以上禁止)
  validates :comment, presence: true, length: { maximum: 100 }
  #-----------------------------------------------------------------------
end
