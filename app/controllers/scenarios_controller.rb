class ScenariosController < ApplicationController

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
      redirect_to scenario_path(@scenario), notice: "シナリオ投稿が完了しました"
    else
      @scenarios = Scenario.all
      render 'index'
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])
    # @tag_list =@scenario.tags.pluck(:tag).join(",")
    # count = 1
    # @scenario.tags.pluck(:tag).each do |tag|
    #   case count
    #   when "1"
    #     @tag_list_1 = 1
    #   when "2"
    #     @tag_list_2 = 2
    #   when "3"
    #     @tag_list_3 = 3
    #   end
    #   count += 1
    # end
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
       @scenarios = Scenario.includes(:liked_users).where(created_at: Time.current.all_week).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
       @scenarios = Scenario.scenario_favorites.
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
  end

  private

  def scenario_params
    params.require(:scenario).permit(:title, :overview, :scenario_image, :system_category, :level, :upper_limit_count, :lower_limit_count, :play_genre, :play_time, :content)
  end


  # def search_for(value)
  #   Scenario.where("name LIKE ?", "%#{value}%")
  # end

  # def genre_search_for(value)
  #   Scenario.where(tag_id: value)
  # end

end