class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[signup login]

  def signup
    user = User.new(user_params)
    if user.save
      render json: { msg: 'Signup was successful' }, status: 201
    else
      render json: user.errors.full_messages, status: 400
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      token = jwt_encode({ user_id: user.id })
      render json: { msg: 'Login successfully', token: }, status: 200
    else
      render json: { error: 'wrong credential provided' }, status: :unprocessable_entity
    end
  end

  def not_found
    render json: { msg: 'Invalid Route' }, status: 404
  end

  private

  def user_params
    params.permit(:name, :username, :password)
  end
end
