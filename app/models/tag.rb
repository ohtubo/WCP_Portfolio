class Tag < ApplicationRecord
  has_many  :scenario_tags, dependent: :destroy
  has_many  :scenarios, through: :scenario_tags
  validates :tag, uniqueness: true
end
