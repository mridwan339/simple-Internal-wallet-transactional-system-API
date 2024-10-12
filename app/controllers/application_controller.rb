require 'base64'

class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate_request
    def authenticate_request
        token = request.headers['Authorization']&.split(' ')&.last
        unless token && valid_token?(token)
        render json: { error: 'Unauthorized access' }, status: :unauthorized
        end
    end
    
    def valid_token?(token)
        begin
            decoded_token = Base64.decode64(token)
            payload = JSON.parse(decoded_token)
            return false if payload['exp'] < Time.now.to_i
                true
            rescue
                false
        end
    end
end
