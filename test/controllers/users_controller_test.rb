require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {user: { name:@user.name,
                                             email: @user.email}}
    assert_not flash.empty?
  end

  test "should redirect edit when logged as wrong user" do
    get edit_user_path(@user)
    assert_redirected_to login_path
    post login_path, params: { session: { email: @other.email, password: "password", remember:'0' } }
    assert_response :success
    get edit_user_path(@user)
    follow_redirect!
    puts flash.inspect
    assert_response :success
    #assert_redirected_to login_path
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
end
