class Api::V1::SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      render json: { message: 'Signed in successfully.', user: { id: user.id, email: user.email } }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: 'Signed out successfully.' }, status: :ok
  end
end
