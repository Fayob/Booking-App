require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secret_key_base

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    token = JWT.encode(payload, SECRET_KEY)
    request.headers['Authorization'] = token
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
