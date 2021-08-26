class ScenarioComment < ApplicationRecord
  belongs_to :user
  belongs_to :scenario

  validates :comment, presence: true, length: {maximum: 100}
end

