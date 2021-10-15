class ScenariosController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :ensure_correct_user, only: %i(edit update)

  def new
    @scenario = Scenario.new
  end

  def create
    @scenario = Scenario.new(scenario_params)
    @scenario.user_id = current_user.id

    # ↓短いが、空データも入れてしまう。
    # tag_list.push(params[:scenario][:tag_id_1], params[:scenario][:tag_id_2], params[:scenario][:tag_id_3])
    # 全角スペースを半角スペースに変換後、前後の空白文字を削除する[.strip]
    tag_ids = params[:scenario][:tag_id_1].gsub(/　/, " ").strip + ',' + params[:scenario][:tag_id_2].gsub(/　/, " ").strip + ',' + params[:scenario][:tag_id_3].gsub(/　/, " ").strip

    if @scenario.save

      # API実装
      # byebug
      # @scenario.scenario_imageがnillの場合、base64にエンコードできない為分岐させる。
      unless @scenario.scenario_image.nil?
        ai_tags = Vision.get_image_data(@scenario.scenario_image)
        ai_tags.each do |ai_tag|
          # @scenario.tags.create(tag: ai_tag)
          ai_tag = Translation.get_Translation_data(ai_tag)
          tag_ids = tag_ids + ',' + ai_tag
        end
      end
      tag_list = []
      tag_list = tag_ids.split(',')
      # 配列からnilと空文字を取り除く
      tag_list = tag_list.compact.delete_if(&:empty?)
      @scenario.save_tags(tag_list)
      redirect_to scenario_path(@scenario), notice: 'シナリオ投稿が完了しました。'
    else
      render 'new'
    end
  end

  def edit
    @scenario = Scenario.find(params[:id])
    # カラム「tag」のみ表示[pluck(:tag)]
    # データを1つのみ表示[limit(1)]
    # データの2番目から表示[offset(1)]
    @tag_list_1 = @scenario.tags.limit(1).pluck(:tag)
    @tag_list_2 = @scenario.tags.limit(1).offset(1).pluck(:tag)
    @tag_list_3 = @scenario.tags.limit(1).offset(2).pluck(:tag)
  end

  def update
    @scenario = Scenario.find(params[:id])
    # tag_list = params[:scenario][:tag_ids].split(',')
    # 全角スペースを半角スペースに変換後、前後の空白文字を削除する[.strip]
    tag_ids = params[:scenario][:tag_id_1].gsub(/　/, " ").strip + ',' + params[:scenario][:tag_id_2].gsub(/　/, " ").strip + ',' + params[:scenario][:tag_id_3].gsub(/　/, " ").strip
    if @scenario.update(scenario_params)

      # API実装
      # byebug
      unless @scenario.scenario_image.nil?
        ai_tags = Vision.get_image_data(@scenario.scenario_image)
        ai_tags.each do |ai_tag|
          # @scenario.tags.create(tag: ai_tag)
          ai_tag = Translation.get_Translation_data(ai_tag)
          tag_ids = tag_ids + ',' + ai_tag
        end
      end

      tag_list = []
      tag_list = tag_ids.split(',')
      # 配列からnilと空文字を取り除く
      tag_list = tag_list.compact.delete_if(&:empty?)
      @scenario.save_tags(tag_list)
      redirect_to scenario_path(@scenario), notice: 'シナリオ編集が完了しました。'
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
    when '0'
      @scenarios = Scenario.includes(:liked_users).sort { |a, b| b.liked_users.size <=> a.liked_users.size }
    when '1'
      # @scenarios= Scenario.find(ScenarioFavorite.group(:scenario_id).where(created_at: Time.current.all_day).order('count(scenario_id) desc').pluck(:scenario_id))
      @scenarios = Scenario.includes(:liked_users).where(created_at: Time.current.all_week).sort do |a, b|
        b.liked_users.size <=> a.liked_users.size
      end

    # 週刊いいね順
    # @scenarios = ScenarioFavorite.where('created_at <= ? AND created_at >= ?', Time.zone.now, Time.zone.now - 1.weeks)
    #                               .select('scenario_id, user_id, count(scenario_id) as scenarios_count')
    #                               .group(:scenario_id)
    #                               .order(scenarios_count: 'DESC')
    #                               .scenarios

    when '2'
      @scenarios = Scenario.all.order(created_at: :desc)
    when '3'

      @search_select = params[:search_select]
      @system_category = params[:system_category]
      @level = params[:level]
      @upper_limit_count = params[:upper_limit_count]
      @play_genre = params[:play_genre]
      @play_time = params[:play_time]

      @records = Scenario.search_for(@search_select, @system_category, @level, @upper_limit_count, @play_genre,
                                     @play_time)
      @scenarios = @records
    when '4'
      if params['tag_id'].nil?
        @scenarios = Scenario.all.order(created_at: :desc)
      else
        @tag = Tag.find(params['tag_id'])
        @scenarios = @tag.scenarios
      end
    when '5'
      @search_category = params[:search_category]
      if @search_category == 'プレイ時間'
        @search_word_1 = params[:search_word_1]
        @search_word_2 = params[:search_word_2]
        @records = Scenario.search_for_category(@search_category, @search_word_1, @search_word_2)
        @scenarios = @records
      else
        @search_word_1 = params[:search_word]
        @search_word_2 = ''

        @records = Scenario.search_for_category(@search_category, @search_word_1, @search_word_2)
        @scenarios = @records
      end

    else
      @scenarios = Scenario.all.order(created_at: :desc)
    end

    @scenarios_count = @scenarios
    # いいねのsotoが配列の為kaminari の paginate_array メソッド使用
    @scenarios = Kaminari.paginate_array(@scenarios).page(params[:page]).per(10)
  end

  private

  def scenario_params
    params.require(:scenario).permit(:title, :overview, :scenario_image, :system_category, :level, :upper_limit_count,
                                     :lower_limit_count, :play_genre, :play_time, :content)
  end

  def ensure_correct_user
    @scenario = Scenario.find(params[:id])
    redirect_to scenario_path(@scenario), alert: '編集権限がありません。' unless @scenario.user == current_user
  end
end
