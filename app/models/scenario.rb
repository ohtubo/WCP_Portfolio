class Scenario < ApplicationRecord

  #refileが「scenario_image」にアクセスできるようにするためattachmentメソッド設定する-----------------------------------
  attachment :scenario_image, destroy: false
  #----------------------------------------------------------------------------------------------------------------------


  #アソシエーションの設定-----------------------------------------------------------------------------------------------

  belongs_to :user
  has_many :scenario_comments, dependent: :destroy
  has_many :scenario_favorites, dependent: :destroy
  has_many :liked_users, through: :scenario_favorites, source: :user

  has_many  :scenario_tags, dependent: :destroy
  has_many  :tags, through: :scenario_tags

  #----------------------------------------------------------------------------------------------------------------------


scope :serche_by_system_category, -> (system_category) { where(system_category: system_category)}
scope

  #ヴァリデーションを設定------------------------------------------------------------------------------------------------

  #{presence: true(空白禁止)},{length: { maximum: 30 }(n+1文字以上禁止)},{uniqueness: true(重複禁止)}
  validates :title, presence: true, length: { maximum: 30 }, uniqueness: true
  validates :overview, presence: true, length: { maximum: 250 }
  validates :system_category, presence: true
  validates :level, presence: true
  validates :upper_limit_count, presence: true
  validates :lower_limit_count, presence: true
  validates :play_genre, presence: true
  validates :play_time, presence: true
  validates :content, presence: true, length: { maximum: 5000 }
  validate  :limit_counts

  # [:AAA]シンボル型

  # バリデーションメソッド
  def limit_counts
    # test0 = 1 # => 1 integer型
    # test1 = "1" # => "1" string型
    # test2 = :hoge # => :hoge synbol型
    # byebug
    # 独自のバリデーションの条件 lower_limit_count
    # enumの値を見たい場合は下記参照
    unless Scenario.lower_limit_counts[lower_limit_count].nil?
      unless Scenario.upper_limit_counts[upper_limit_count].nil?
        if Scenario.lower_limit_counts[lower_limit_count] > Scenario.upper_limit_counts[upper_limit_count]
          errors.add(:lower_limit_count, "は[上限値]より小さい値を入力してください") # エラーメッセージ
          errors.add(:upper_limit_count, "は[下限値]より大きい値を入力してください") # エラーメッセージ
        end
      end
    end

  end

  #---------------------------------------------------------------------------------------------------------------------


  #関数-----------------------------------------------------------------------------------------------------------------

  def favorited_by?(user)
    scenario_favorites.where(user_id: user.id).exists?
  end

  #タグの保存(テーブルに値の重複がなければ保存する)
  def save_tags(savescenario_tags)
    current_tags = tags.pluck(:tag)
    unless tags.nil?
      old_tags = current_tags - savescenario_tags
      new_tags = savescenario_tags - current_tags
    end

    old_tags.each do |old_tag|
      tags.delete Tag.find_by(tag: old_tag)
    end

    new_tags.each do |new_tag|
      scenario_tag = Tag.find_or_create_by(tag: new_tag)
      tags << scenario_tag
    end
  end

  #モデル[Scenario]の検索
    #(ANDの場合：カテゴリ,難易度,プレイ時間の完全一致)
    #(ORの場合：カテゴリ,難易度,プレイ時間の部分一致)
  def self.search_for(search_select, system_category, level, _upper_limit_count, play_genre, _play_time)
    # @record = Scenario.where(['system_category ? AND level ?', "#{content}", "#{content}"])
    if search_select == 'AND'
      binding.irb
      #最初から入っているもの。
      
      @record = Scenario.where(['system_category LIKE ? AND level LIKE ? AND play_genre LIKE ?', system_category.to_s,
                                level.to_s, nil ])
    elsif search_select == 'OR'
      @record = Scenario.where(['system_category LIKE ? OR level LIKE ? OR play_genre LIKE ?', system_category.to_s,
                                level.to_s, play_genre.to_s])
    end
    # @record = Scenario.where(['system_category ?', "#{system_category}"])
  end

  #モデル[Scenario]の検索
  def self.search_for_category(search_category, search_word_1, search_word_2)
    if search_category == 'システムカテゴリ'
      @record = Scenario.where(['system_category LIKE ?', search_word_1.to_s])
    elsif search_category == '難易度'
      @record = Scenario.where(['level LIKE ?', search_word_1.to_s])
    elsif search_category == 'プレイ時間'
      @record = Scenario.where(['play_genre LIKE ? AND play_time LIKE ?', search_word_1.to_s, search_word_2.to_s])
    end
  end

  #---------------------------------------------------------------------------------------------------------------------


  #enumの設定-----------------------------------------------------------------------------------------------------------
  enum categories: {
    "クトゥルフ": 1,
    "パラノイア": 2,
    "インセイン": 3,
    "ソードワールド": 4,
    "アリアンロッド": 5,
    "ネクロニカ": 6,
    "ダブルクロス": 7,
    "ゆうやけこやけ": 8,
    "グランクレスト": 9,
    "D&amp;D": 10,
    "ログ・ホライズン": 11,
    "サタスペ": 12,
    "シノビガミ": 13,
    "モノトーンミュージアム": 14,
    "ビギニングアイドル": 15,
    "ウタカゼ": 16,
    "マギカロギア": 17,
    "ガーデンオーダー": 18,
    "ピーカーブー": 19,
    "鵺鏡": 20,
    "神話創世RPGアマデウス": 21,
    "ダークデイズドライブ": 22,
    "ヤンキー＆ヨグ=ソトース": 23,
    "フィアスコ": 24,
    "その他": 50
  }

  enum levels: {
    "★": 1,
    "★★": 2,
    "★★★": 3,
    "★★★★": 4,
    "★★★★★": 5
  }

  enum upper_limit_counts: {
    "1人": 1,
    "2人": 2,
    "3人": 3,
    "4人": 4,
    "5人": 5,
    "6人": 6,
    "7人": 7,
    "8人": 8,
    "9人": 9,
    "上限なし": 10
  }, _suffix: :upper_limit_counts

  # '#{:upper_limit_counts.to_i]人'

  enum lower_limit_counts: {
    "1人": 1,
    "2人": 2,
    "3人": 3,
    "4人": 4,
    "5人": 5,
    "6人": 6,
    "7人": 7,
    "8人": 8,
    "9人": 9
  }, _suffix: :lower_limit_counts

  enum play_genres: {
    "オンライン": 1,
    "オフライン": 2
  }

  enum play_times: {
    "1時間": 1,
    "2時間": 2,
    "3時間": 3,
    "4時間": 4,
    "5時間": 5,
    "6時間": 6,
    "7時間": 7,
    "8時間以上": 8
  }

  enum search_selects: {
    "AND": 1,
    "OR": 2
  }
  #-----------------------------------------------------------------------------------------------------------------------------------
end
