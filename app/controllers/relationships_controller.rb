class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    current_user.active_relationships.build followed_id: params[:followed_id]
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html{redirect_to @users}
      format.js
    end
  end

  def destroy
    relationship = current_user.active_relationships.find_by followed_id:
      params[:followed_id]
    @user = relationship.followed
    current_user.unfollow @user
    respond_to do |format|
      format.html{redirect_to @users}
      format.js
    end
  end
end
