class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: {minimum:3, maximum: 20}       
  validates :last_name, length: {minimum:3, maximum: 20}       


  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end
  
  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
  
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Usuário"
  end

  def self.search(entry)
    entry.strip!
    return nil if entry.empty?
  
    where(
      "LOWER(first_name) LIKE :entry OR LOWER(last_name) LIKE :entry OR LOWER(email) LIKE :entry OR CONCAT(LOWER(first_name), ' ', LOWER(last_name)) LIKE :entry",
      entry: "%#{entry.downcase}%"
    ).distinct
  end

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end
  
end
