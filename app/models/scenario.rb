class Scenario < ApplicationRecord

  attachment :scenario_image, destroy: false

  belongs_to :user
  has_many :scenario_comments, dependent: :destroy
  has_many :scenario_favorites, dependent: :destroy
  has_many :liked_users, through: :scenario_favorites, source: :user

  has_many  :scenario_tags, dependent: :destroy
  has_many  :tags, through: :scenario_tags

  def favorited_by?(user)
    scenario_favorites.where(user_id: user.id).exists?
  end

  def save_tags(savescenario_tags)
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    old_tags = current_tags - savescenario_tags
    new_tags = savescenario_tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag: old_tag)
    end

    new_tags.each do |new_tag|
      scenario_tag = Tag.find_or_create_by(tag: new_tag)
      self.tags << scenario_tag
    end

  end

  def self.search_for(search_select,system_category, level, upper_limit_count, play_genre, play_time)
    # @record = Scenario.where(['system_category ? AND level ?', "#{content}", "#{content}"])
    if search_select == "AND"
      @record = Scenario.where(['system_category LIKE ? AND level LIKE ? AND play_genre LIKE ?', "#{system_category}", "#{level}", "#{play_genre}"])
    elsif search_select == "OR"
      @record = Scenario.where(['system_category LIKE ? OR level LIKE ? OR play_genre LIKE ?', "#{system_category}", "#{level}", "#{play_genre}"])
    end
    # @record = Scenario.where(['system_category ?', "#{system_category}"])
  end

  def self.search_for_category(search_category, search_word_1, search_word_2)
    if search_category == "システムカテゴリ"
      @record = Scenario.where(['system_category LIKE ?', "#{search_word_1}"])
    elsif search_category == "難易度"
      @record = Scenario.where(['level LIKE ?', "#{search_word_1}"])
    elsif search_category == "プレイ時間"
      @record = Scenario.where(['play_genre LIKE ? AND play_time LIKE ?', "#{search_word_1}", "#{search_word_2}"])
    end
  end

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
      "オフライン": 2,
    }

    enum play_times: {
      "1時間": 1,
      "2時間": 2,
      "3時間": 3,
      "4時間": 4,
      "5時間": 5,
      "6時間": 6,
      "7時間": 7,
      "8時間以上": 8,
    }

      enum search_selects: {
      "AND": 1,
      "OR": 2,
    }

end
