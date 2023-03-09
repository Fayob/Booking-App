require 'rails_helper'

RSpec.describe Api::V1::ReservesController, type: :controller do
  describe 'when authenticated' do
    before do
      @user = User.create(name: 'John', username: 'john', password: '123456')
      @coach = Coach.create(user_id: @user.id, name: 'coach name', description: 'Testing Description')
      @reserve = Reserve.create(city: 'Test name', date: '09-03-2023', coach_id: @coach.id, user_id: @user.id)
      @token = JWT.encode({ user_id: @user.id }, Rails.application.secret_key_base)
      request.headers['Authorization'] = "Bearer #{@token}"
    end

    it 'returns a success response after fetching all reserved coaches' do
      get :index
      expect(response).to be_successful
    end

    it 'returns a success response after reserving a coach' do
      post :create, params: { city: 'Test name', date: '09-03-2023', coach_id: @coach.id }
      expect(response).to be_successful
    end

    it 'returns a success response after deleting a reserved coach' do
      delete :destroy, params: { id: @reserve.id, coach_id: @coach.id }
      expect(response).to be_successful
    end
  end
end
