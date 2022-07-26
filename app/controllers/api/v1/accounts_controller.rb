class Api::V1::AccountsController < ApplicationController
  before_action :authorize_request, except: [:create, :login]

  def index
    render json: @current_user, status: 200
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: { data: user }, status: :created
    else
      render json: { error: user.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update(user_update_params)
      render json: { data: @current_user }, status: :ok
     else
      render json: { error: @current_user.errors.messages }, status: 400
     end
  end

  private

  def user_params
    params.permit(:email, :first_name, :last_name, :password)
  end

  def user_update_params
    params.permit(:email, :password)
  end
end
