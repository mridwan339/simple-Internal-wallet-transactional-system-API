require 'base64'
class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      token = generate_token(user)
      render json: { message: 'Signed in successfully.', token: token, user: { id: user.id, email: user.email } }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'Signed out successfully.' }, status: :ok
  end

  private

  def generate_token(user)
    payload = {
      user_id: user.id,
      exp: (Time.now + 24.hours).to_i
    }
    Base64.encode64(payload.to_json)
  end
end
