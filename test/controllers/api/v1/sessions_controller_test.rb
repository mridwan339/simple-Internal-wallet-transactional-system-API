require "test_helper"

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: 'John Doe', email: 'john@example.com', password: 'password123')
  end

  test "should sign in with valid email and password" do
    post '/api/v1/sessions', params: { email: @user.email, password: 'password123' }
    assert_response :success
    assert_equal @user.id, session[:user_id]
  end

  test "should not sign in with invalid password" do
    post '/api/v1/sessions', params: { email: @user.email, password: 'wrongpassword' }
    assert_response :unauthorized
    assert_nil session[:user_id]
  end

  test "should sign out user" do
    # Simulate a signed-in user
    post '/api/v1/sessions', params: { email: @user.email, password: 'password123' }
    assert_response :success
    assert_equal @user.id, session[:user_id]

    delete '/api/v1/sessions'
    assert_response :success
    assert_nil session[:user_id]
  end
end
