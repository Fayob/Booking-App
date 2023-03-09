require 'rails_helper'

describe 'routes to reserves controller', type: :routing do
  it 'should route to index' do
    expect(get('/api/v1/reserves')).to route_to('api/v1/reserves#index', format: :json)
  end
  it 'should route to create' do
    expect(post('/api/v1/coaches/1/reserves')).to route_to('api/v1/reserves#create', format: :json, coach_id: '1')
  end
  it 'should route to destroy' do
    expect(delete('/api/v1/coaches/1/reserves/1')).to route_to('api/v1/reserves#destroy', format: :json, id: '1',
                                                                                          coach_id: '1')
  end
end
