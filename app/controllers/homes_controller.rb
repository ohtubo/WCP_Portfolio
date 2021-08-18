class HomesController < ApplicationController
  def top
    @scenarios = Scenario.all.order(created_at: :desc)
  end
end
