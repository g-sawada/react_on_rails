class UsersController < ApplicationController
  def index
    @users = User.all.includes(:graphs, :templates, :graph_settings)
  end

  def show
    @user = User.find(params[:id])
  end
end
