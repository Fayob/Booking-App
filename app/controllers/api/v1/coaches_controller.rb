class Api::V1::CoachesController < ApplicationController

  def index
    coaches = Coach.all
    render json: coaches, status: :ok
  end

  def show
    coach = Coach.find(params[:id])
    render json: coach, status: 200
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: }, status: 404
  end

  def create
    coach = @current_user.coaches.new(coach_params)
    if coach.save
      render json: { msg: "Coach was added successfully" }, status: 201
    else
      render json: coach.errors.full_messages, status: :unprocessable_entity # status code is 422
    end
  end

  def destroy
    coach = Coach.find(params[:id])
    if coach.destroy
      render json: { msg: 'Coach was deleted successfully' }
    end
  rescue ActiveRecord::RecordNotFound => error
    render json: { error: }, status: 404
  end

  private

  def coach_params
    params.permit(:name, :description, :image)
  end
end