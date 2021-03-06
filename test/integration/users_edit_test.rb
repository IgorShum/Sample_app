require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful" do
    get edit_user_path @user
    post login_path, params: { session: { email: @user.email, password: 'password', remember:'0' } }
    inspect
    assert_redirected_to edit_user_path@user
    follow_redirect!
    assert_template 'users/edit'
    get edit_user_path @user
    patch user_path(@user), params: {user: { name:'',
                                     email: 'foo@invalid',
                                     password: 'foo',
                                     password_confirmation: 'bar'}}
    assert_template 'users/edit'
    assert_equal flash[:danger], "Profile not updated!"
  end

  test "successful" do
    get edit_user_path @user
    post login_path, params: { session: { email: @user.email, password: 'password', remember:'0' } }
    assert_redirected_to edit_user_path @user
    follow_redirect!
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "MyEmail@yandex.ru"
    patch user_path(@user), params: {user: { name:name,
                                             email: email,
                                             password: '',
                                             password_confirmation: ''}}
    #assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email.downcase!
    assert_equal flash[:success], "Profile updated!"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path @user
    post login_path, params: { session: { email: @user.email, password: 'password', remember:'0' } }
    assert_redirected_to edit_user_path @user
    follow_redirect!
    assert_template 'users/edit'
    name = "Freindly Forwarding"
    email = "Freindly@forward.ru"
    patch user_path(@user), params: {user: { name:name,
                                             email: email,
                                             password: 'password',
                                             password_confirmation: 'password'}}
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email.downcase!
  end
end
