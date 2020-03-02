class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:follow_id])
    if current_user != @user
      current_user.following(@user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:follow_id])
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)    
  end

end
