class ScenariosController < ApplicationController
  before_action :authenticate_user!,except: [:index,:show]
  before_action :ensure_correct_user, only: [:edit,:update]

  def new
    @scenario = Scenario.new
  end

  def create
    @scenario = Scenario.new(scenario_params)
    @scenario.user_id = current_user.id
    tag_list = []
    tag_list.push(params[:scenario][:tag_id_1] ,params[:scenario][:tag_id_2],params[:scenario][:tag_id_3])
    # tag_ids = params[:scenario][:tag_id_1]+","+params[:scenario][:tag_id_2]+","+params[:scenario][:tag_id_3]
    # tag_list = tag_ids.split(',')
    if @scenario.save
      @scenario.save_tags(tag_list)
      redirect_to scenario_path(@scenario), notice: "シナリオ投稿が完了しました。"
    else
      render 'new'
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])
    @tag_list_1 = @scenario.tags.limit(1).pluck(:tag)
    @tag_list_2 = @scenario.tags.limit(1).offset(1).pluck(:tag)
    @tag_list_3 = @scenario.tags.limit(1).offset(2).pluck(:tag)

  end

  def update
    @scenario = Scenario.find(params[:id])
    # tag_list = params[:scenario][:tag_ids].split(',')
    tag_ids = params[:scenario][:tag_id_1]+","+params[:scenario][:tag_id_2]+","+params[:scenario][:tag_id_3]
    tag_list = tag_ids.split(',')
    if @scenario.update(scenario_params)
      @scenario.save_tags(tag_list)
      redirect_to scenario_path(@scenario), notice: "シナリオ編集が完了しました。"
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
      @scenarios = Scenario.includes(:liked_users).where(created_at: Time.current.all_week).sort {|a,b| b.liked_users.size <=> a.liked_users.size}

      #週刊いいね順
      # @scenarios = ScenarioFavorite.where('created_at <= ? AND created_at >= ?', Time.zone.now, Time.zone.now - 1.weeks)
      #                               .select('scenario_id, user_id, count(scenario_id) as scenarios_count')
      #                               .group(:scenario_id)
      #                               .order(scenarios_count: 'DESC')
      #                               .scenarios

     when "2"
       @scenarios = Scenario.all.order(created_at: :desc)
     when "3"

        @search_select = params[:search_select]
        @system_category  = params[:system_category]
        @level  = params[:level]
        @upper_limit_count  = params[:upper_limit_count]
        @play_genre  = params[:play_genre]
        @play_time  = params[:play_time]

        @records = Scenario.search_for(@search_select, @system_category, @level, @upper_limit_count, @play_genre, @play_time)
        @scenarios = @records
     when "4"
        unless params["tag_id"].nil?
          @tag = Tag.find(params["tag_id"])
          @scenarios = @tag.scenarios
        else
          @scenarios = Scenario.all.order(created_at: :desc)
        end
     when "5"
       @search_category = params[:search_category]
       unless @search_category == "プレイ時間"
        @search_word_1 = params[:search_word]
        @search_word_2 = ""

        @records = Scenario.search_for_category(@search_category, @search_word_1, @search_word_2)
        @scenarios = @records
       else
        @search_word_1 = params[:search_word_1]
        @search_word_2 = params[:search_word_2]
        @records = Scenario.search_for_category(@search_category, @search_word_1, @search_word_2)
        @scenarios = @records
       end

     else
       @scenarios = Scenario.all.order(created_at: :desc)
     end

     @scenarios_count = @scenarios
     #いいねのsotoが配列の為kaminari の paginate_array メソッド使用
     @scenarios = Kaminari.paginate_array(@scenarios).page(params[:page]).per(3)

  end

  private

  def scenario_params
    params.require(:scenario).permit(:title, :overview, :scenario_image, :system_category, :level, :upper_limit_count, :lower_limit_count, :play_genre, :play_time, :content)
  end

  def ensure_correct_user
    @scenario = Scenario.find(params[:id])
    unless @scenario.user == current_user
      redirect_to scenario_path(@scenario), alert: "編集権限がありません。"
    end
  end

end