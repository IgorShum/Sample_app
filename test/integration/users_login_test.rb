require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    user_params = { email: "", password: "" }
    post login_path, params: {session: user_params}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    assert_select ".button_to[action=?]", login_path, count: 1
    assert_select ".button_to[action=?]", signup_path, count: 1
    post login_path, params: {session: {email: @user.email, password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count:0
    assert_select ".button_to[action=?]", logout_path
    assert_select ".button_to[action=?]", user_path(@user)
  end
end
