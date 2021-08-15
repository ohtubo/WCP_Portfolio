class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @scenarios = @user.scenarios
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def scenario_favorites
    @user = User.find(params[:id])
    scenario_favorites = ScenarioFavorite.where(user_id: @user.id).pluck(:scenario_id)
    @scenarios = Scenario.find(scenario_favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :self_introduction, :icon_image)
  end
end
