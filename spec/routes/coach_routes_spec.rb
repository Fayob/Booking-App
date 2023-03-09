require 'rails_helper'

describe 'routes to coaches controller', type: :routing do
  it 'should route to index' do
    expect(get api_v1_coaches_path).to route_to('api/v1/coaches#index', format: :json)
  end
  it 'should route to show' do
    expect(get api_v1_coach_path(1)).to route_to('api/v1/coaches#show', format: :json, id: '1')
  end
  it 'should route to create' do
    expect(post api_v1_coaches_path).to route_to('api/v1/coaches#create', format: :json)
  end
  it 'should route to destroy' do
    expect(delete api_v1_coach_path(1)).to route_to('api/v1/coaches#destroy', format: :json, id: '1')
  end
end