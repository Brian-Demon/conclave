require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get "/auth/google_oauth2/callback"
    assert_redirected_to "http://www.example.com/auth/failure?message=csrf_detected&strategy=google_oauth2"
  end

  test "should get destroy" do
    delete logout_url
    assert_redirected_to root_url
  end
end
