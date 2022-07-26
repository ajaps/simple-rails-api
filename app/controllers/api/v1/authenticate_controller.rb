class Api::V1::AuthenticateController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = 1.day.from_now
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                      email: @user.email }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
