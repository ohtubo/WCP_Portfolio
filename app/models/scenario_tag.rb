class ScenarioTag < ApplicationRecord
  belongs_to :scenario
  belongs_to :tag
end
