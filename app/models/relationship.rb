class Relationship < ApplicationRecord
  #User：followerが1:Nの関係
  belongs_to :follower, class_name: 'User'
  #User：followedが1:Nの関係
  belongs_to :followed, class_name: 'User'
end
