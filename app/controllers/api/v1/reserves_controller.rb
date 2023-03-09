class Api::V1::ReservesController < ApplicationController
  def index
    reserves = @current_user.reserves
    reserved_coaches = []
    reserves.each do |reserve|
      coach = reserve.coach
      reserved_coaches << { id: reserve.id, name: coach.name, description: coach.description,
                           image: coach.image, city: reserve.city, date: reserve.date }
    end
    render json: reserved_coaches, status: 200
  end

  def create
    reserve = @current_user.reserves.build(reserve_params)
    if reserve.save
      render json: { msg: 'Coach Reserved' }, status: 201
    else
      render json: reserve.errors.full_messages, status: 422
    end
  end

  def destroy
    reserve = Reserve.find(params[:id])
    render json: { msg: 'Coach was successfully removed from reservation list ' }, status: :ok if reserve.destroy
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e }, status: 404
  end

  private

  def reserve_params
    params.permit(:city, :date, :coach_id)
  end
end
