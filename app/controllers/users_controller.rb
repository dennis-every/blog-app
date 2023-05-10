class UsersController < ApplicationController
  def index
    @users = User.order(id: :asc)
  end

  def show; end
end
