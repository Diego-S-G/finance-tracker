class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: params[:friend])
    if current_user.save
      flash[:notice] = "Você está seguindo #{friend.full_name}!"
    else
      flash[:alert] = "Algo de errado aconteceu..."
    end
    redirect_to my_friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Você parou de seguir #{friendship.friend.full_name}"
    redirect_to my_friends_path
  end
end
