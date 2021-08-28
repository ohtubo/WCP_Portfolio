class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show scenario_favorites]
  before_action :ensure_correct_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    @scenarios = @user.scenarios
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'プロフィール編集が完了しました'
    else
      render 'edit'
    end
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

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(@user.id), alert: '編集権限がありません。' unless @user == current_user
  end
end
