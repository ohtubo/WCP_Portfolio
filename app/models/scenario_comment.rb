class ScenarioComment < ApplicationRecord
  belongs_to :user
  belongs_to :scenario
end

