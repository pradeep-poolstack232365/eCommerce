class Admin::SessionsController < ActiveAdmin::Devise::SessionsController
  def new
  	flash[:notice] = "Welcome to the admin login page"
    super
  end

  def create
    super
  end

  def destroy
    super
  end
end