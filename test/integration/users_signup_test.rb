require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      user_params = {
          name:"",
          email: "error@email",
          password: "foo",
          password_confirmation: "bar"
      }
        post users_path, params: {user: user_params}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      user_params = {
          name:"TestName",
          email: "TestMail@test.ts",
          password: "testcases",
          password_confirmation: "testcases"
      }
      post users_path, params: {user:user_params}
      follow_redirect!
    end
    assert_response(:success)
    assert_template 'users/show'
    assert_empty 'div#error_explanation'
    assert_empty 'div.alert'
  end

end
