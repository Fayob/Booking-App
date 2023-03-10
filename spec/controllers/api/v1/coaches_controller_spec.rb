require 'rails_helper'

RSpec.describe Api::V1::CoachesController, type: :controller do
  describe 'when authenticated' do
    before do
      @user = User.create(name: 'John', username: 'john', password: '123456')
      @coach = Coach.create(user_id: @user.id, name: 'coach name', description: 'Testing Description')
      @token = JWT.encode({ user_id: @user.id }, Rails.application.secret_key_base)
      request.headers['Authorization'] = "Bearer #{@token}"
    end

    it 'returns a success response when it getting all coaches' do
      get :index
      expect(response).to be_successful
    end

    it 'returns a success response after creating a coach' do
      post :create, params: { name: 'Test name', description: 'Testing Description' }
      expect(response).to be_successful
    end

    it 'returns a not successful response if params id is wrong' do
      get :show, params: { id: 'a' }
      expect(response).to_not be_successful
    end

    it 'returns a success response if correct params id passed' do
      get :show, params: { id: @coach.id }
      expect(response).to be_successful
    end

    it 'returns a success response after deleting a coach' do
      delete :destroy, params: { id: @coach.id }
      expect(response).to be_successful
    end
  end
end
