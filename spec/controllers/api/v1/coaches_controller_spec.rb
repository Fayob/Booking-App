require 'rails_helper'

RSpec.describe Api::V1::CoachesController, type: :request do
  describe 'get /api/v1/coaches' do
    context 'when getting all available coach' do
      it 'returns a success status code' do
        get api_v1_coaches_path
        expect(response).to have_http_status(200)
      end
    end

    # context "when logging in with invalid credentials" do
    #   it "returns an error status code" do
    #     post api_v1_login_path, params: { username: 'john', password: 'wrong_password' }
    #     expect(response).to have_http_status(404)
    #   end
    # end
  end
end
