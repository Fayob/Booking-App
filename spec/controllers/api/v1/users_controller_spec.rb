require 'rails_helper'

describe Api::V1::UsersController do
  describe '#signup' do
    it 'creates a new user' do
      post :signup, params: { name: 'John', username: 'john', password: 'password' }
      expect(response).to have_http_status(:created)
    end

    it 'should throw an error' do
      post :signup, params: { username: 'john', password: 'password' }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#login' do
    # it 'logs in an existing user' do
    #   post :login, params: { username: 'john', password: 'password' }
    #   expect(response).to have_http_status(:ok)
    # end

    it 'should throw an error' do
      post :login, params: { username: 'john' }
      expect(response).to_not have_http_status(:ok)
    end
  end
end
