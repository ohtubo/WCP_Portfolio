class ScenarioFavoritesController < ApplicationController
  def create
    scenario = Scenario.find(params[:scenario_id])
    favorite = current_user.scenario_favorites.new(scenario_id: scenario.id)
    favorite.save
    redirect_to scenario_path(scenario)
  end

  def destroy
    scenario = Scenario.find(params[:scenario_id])
    favorite = current_user.scenario_favorites.find_by(scenario_id: scenario.id)
    favorite.destroy
    redirect_to scenario_path(scenario)
  end

  # def show
  #   scenario = Scenario.find(params[:id])
  #   @scenarios = Scenario_Favorite.scenarios
  #   # @user = Scenario_Favorite.user
  # end
end
