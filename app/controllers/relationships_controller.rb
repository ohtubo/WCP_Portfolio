class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    flash.now[:notice] = 'フォローしました。'
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
    flash.now[:notice] = 'フォローが解除されました。'
  end

  # フォロー一覧を表示するアクション
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    @user = User.find(params[:user_id])
    @usertitle = 'フォロー'
  end

  # フォロワー一覧を表示するアクション
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    @user = User.find(params[:user_id])
    @usertitle = 'フォロワー'
  end
end
