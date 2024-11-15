class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        @tracked_stocks = current_user.stocks
        render 'users/my_portfolio'
      else
        flash[:alert] = 'Por favor insira uma sigla válida.'
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = 'Por favor insira uma sigla para pesquisar.'
      redirect_to my_portfolio_path
    end
  end

  def if_api_usage_limit
    if params[:stock].present?
      @stock = Stock.find_by(ticker: params[:stock])
      if @stock
        @tracked_stocks = current_user.stocks
        render 'users/my_portfolio'
      else
        flash[:alert] = 'Por favor insira uma sigla válida.'
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = 'Por favor insira uma sigla para pesquisar.'
      redirect_to my_portfolio_path
    end
  end
end
