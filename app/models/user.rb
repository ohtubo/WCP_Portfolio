class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :icon_image, destroy: false

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

  has_many :scenarios, dependent: :destroy
  has_many :scenario_comments, dependent: :destroy
  has_many :scenario_favorites, dependent: :destroy
  has_many :liked_scenarios, through: :scenario_favorites, source: :scenario

  validates :name, presence: true, length: { maximum: 20, minimum: 2 }, uniqueness: true
  validates :self_introduction, length: { maximum: 150 }

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
