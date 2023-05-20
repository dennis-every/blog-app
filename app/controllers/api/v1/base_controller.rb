class Api::V1::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :configure_permitted_parameters
  before_action :authenticate

  private

  def authenticate
    token = request.headers['Authorization']
    @authorized_user = User.find_by(auth_token: token)

    render json: { error: 'Not Authorized' }, status: 401 unless @authorized_user
  end
end
