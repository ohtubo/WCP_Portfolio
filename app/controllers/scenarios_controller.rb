class ScenariosController < ApplicationController
  
  def new
    @scenario = Scenario.new
  end
  
  def create
    @scenario = Scenario.new(scenario_params)
    @scenario.user_id = current_user.id
    @scenario.save
    redirect_to scenario_path(@scenario), notice: "シナリオ投稿が完了しました"
    # if @scenario.save
    #   redirect_to book_path(@scenario), notice: "シナリオ投稿が完了しました"
    # else
    #   @books = Scenario.all
    #   render ''
    # end
  end
  
  def show
    @scenario = Scenario.find(params[:id])
    @user = @scenario.user
    @Scenario_comment = ScenarioComment.new
  end
  
  def index
    @scenarios = Scenario.all
  end
  
  private

  def scenario_params
    params.require(:scenario).permit(:title, :overview, :scenario_image, :system_category, :level, :upper_limit_count, :lower_limit_count, :play_genre, :play_time, :content)
  end
  
end