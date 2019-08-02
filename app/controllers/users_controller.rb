class UsersController < ApplicationController
  before_action :admin_only!, only: :index

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: current_user&.is_admin ? params[:id] : current_user.id)
  end
end
