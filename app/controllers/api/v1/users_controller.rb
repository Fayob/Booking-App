class Api::V1::UsersController < ApplicationController

  def signup
    user = User.new(name: params[:name], username: params[:username], password: params[:password])
    if user.save
      render json: {msg: 'Signup was successful'}, status: 201
    else
      render json: user.errors.full_messages, status: 400
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: {msg: 'Login successfully', id: user.id, name: user.name, username: user.username}, status: 200
    else
      render json: {msg: 'wrong credential provided'}, status: 400
    end
  end
end
