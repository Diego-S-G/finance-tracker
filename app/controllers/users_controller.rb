class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @user_friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search_user_friend
    entry = params[:friend] 
   
    if entry.present?
      @friends = User.search(entry).to_a #teve que passar pra array pois dava conflito com o delete e distinct no model
      @friends.delete(current_user)
      if @friends && !@friends.empty?
        @user_friends = current_user.friends
        render 'users/my_friends'
      else
        flash[:alert] = 'Usuário não encontrado.'
        redirect_to my_friends_path
      end
    else
      flash[:alert] = 'Por favor insira um nome ou e-mail para pesquisar.'
      redirect_to my_friends_path
    end
  end
end
