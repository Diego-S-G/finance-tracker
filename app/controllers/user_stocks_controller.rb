class UserStocksController < ApplicationController
  def create
    stock = Stock.check_db(params[:ticker])
    # if stock.blank?
    #   stock = Stock.new_lookup(params[:ticker])
    #   stock.save
    # end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Ação #{stock.name} foi adicionado ao seu portfólio com sucesso!"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} foi removido do portfólio com sucesso."
    redirect_to my_portfolio_path
  end
end
