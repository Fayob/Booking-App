require 'rails_helper'

describe 'routes to users controller', type: :routing do
  it 'should route to signup' do
    expect(post(api_v1_signup_path)).to route_to('api/v1/users#signup', format: :json)
  end
  it 'should route to login' do
    expect(post(api_v1_login_path)).to route_to('api/v1/users#login', format: :json)
  end
  it 'should route to not_found' do
    expect(get('/api/v1/qwee')).to route_to('api/v1/users#not_found', format: :json, a: 'qwee')
  end
end
