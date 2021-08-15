class ScenariosController < ApplicationController

  def new
    @scenario = Scenario.new
  end

  def create
    @scenario = Scenario.new(scenario_params)
    @scenario.user_id = current_user.id
    tag_list = params[:scenario][:tag_ids].split(',')
    if @scenario.save
      @scenario.save_tags(tag_list)
      redirect_to scenario_path(@scenario), notice: "シナリオ投稿が完了しました"
    else
      @scenarios = Scenario.all
      render 'index'
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])
  end

  def update
    @scenario = Scenario.find(params[:id])
    @scenario.update(scenario_params)
    redirect_to scenario_path(@scenario), notice: "シナリオ編集が完了しました"
  end

  def destroy
    scenario = Scenario.find(params[:id])
    scenario.destroy
    redirect_to scenarios_path
  end

  def show
    @scenario = Scenario.find(params[:id])
    @user = @scenario.user
    @Scenario_comment = ScenarioComment.new
    @scenario_favorite = @scenario.scenario_favorites
  end

  def index
    @scenarios = Scenario.all
  end

  private

  def scenario_params
    params.require(:scenario).permit(:title, :overview, :scenario_image, :system_category, :level, :upper_limit_count, :lower_limit_count, :play_genre, :play_time, :content)
  end

end