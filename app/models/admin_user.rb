class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  before_commit :set_flash

  private
  def set_flash
    flash[:notice] = "Welcome to the admin login page"
  end

end
