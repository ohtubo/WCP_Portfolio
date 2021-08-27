class HomesController < ApplicationController
  def top
    @scenarios = Scenario.all.order(created_at: :desc).page(params[:page]).per(3)
  end
end
