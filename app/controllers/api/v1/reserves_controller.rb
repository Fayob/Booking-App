class Api::V1::ReservesController < ApplicationController
  def index
    reserves = @current_user.reserves
    reserve_coaches = []
    reserves.each do |reserve|
      coach = reserve.coach
      reserve_coaches << coach
    end
    render json: reserve_coaches
  end

  def create
    reserve = @current_user.reserve.build(coach_id: params[:coach_id])
    if reserve.save
      render json: { msg: 'Coach Reserved' }, status: 201
    else
      render json: { error: 'Unable to reserve coach' }, status: 422
    end
  end

  def destroy
    reserve = Reserve.find(params[:id])
    render json: { msg: 'Coach was successfully removed from reservation list ' }, status: :ok if reserve.destroy
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e }, status: 404
  end
end
