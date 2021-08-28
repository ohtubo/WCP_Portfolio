class ScenarioFavoritesController < ApplicationController
  def create
    @scenario = Scenario.find(params[:scenario_id])
    favorite = current_user.scenario_favorites.new(scenario_id: @scenario.id)
    flash.now[:notice] = 'いいねしました。'
    favorite.save
    # redirect_to request.referer, notice: "いいねしました。"
  end

  def destroy
    @scenario = Scenario.find(params[:scenario_id])
    favorite = current_user.scenario_favorites.find_by(scenario_id: @scenario.id)
    flash.now[:notice] = 'いいねが解除されました。'
    favorite.destroy
    # redirect_to request.referer, notice: "いいねが解除されました。"
  end

  # def show
  #   scenario = Scenario.find(params[:id])
  #   @scenarios = Scenario_Favorite.scenarios
  #   # @user = Scenario_Favorite.user
  # end
end
