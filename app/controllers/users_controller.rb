class UsersController < ApplicationController
  def index
    @users = User.all.includes(:graphs, :templates)
  end

  def show
    @user = User.find(params[:id])
  end
end
