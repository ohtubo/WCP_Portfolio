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
    @tag_list =@scenario.tags.pluck(:tag).join(",")
  end

  def update
    @scenario = Scenario.find(params[:id])
    tag_list = params[:scenario][:tag_ids].split(',')
    if @scenario.update(scenario_params)
      @scenario.save_tags(tag_list)
      redirect_to scenario_path(@scenario), notice: "シナリオ編集が完了しました"
    else
      render 'edit'
    end

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
     case params[:sort]
     when "0"
       @scenarios = Scenario.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
     when "1"
      # @scenarios= Scenario.find(ScenarioFavorite.group(:scenario_id).where(created_at: Time.current.all_day).order('count(scenario_id) desc').pluck(:scenario_id))
       @scenarios = Scenario.includes(:liked_users).where(created_at: Time.current.all_day).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
     when "2"
       @scenarios = Scenario.all.order(created_at: :desc)
     when "3"
       @scenarios = @records
     end
  end

  private

  def scenario_params
    params.require(:scenario).permit(:title, :overview, :scenario_image, :system_category, :level, :upper_limit_count, :lower_limit_count, :play_genre, :play_time, :content)
  end

end