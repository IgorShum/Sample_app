require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(email: 'Ya@ya.ru', name: 'Яндекс', password: 'foobar', password_confirmation: 'foobar')
  end

  test 'valid user?' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'b' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid adresses' do
    valid_adresses = %w[user@exemple.com USER@foo.com A_US-ER@foo.bar.com first.last@foo.jp alice+bob@baz.org]
    valid_adresses.each do |v_a|
      @user.email = v_a
      assert @user.valid?, "#{v_a.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'email should be unique' do
    dublicate_user = @user.dup
    @user.save
    dublicate_user.email = @user.email.upcase
    assert_not dublicate_user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'email adresses should be save as lower-case' do
    mixed_case_email = 'FoOBaR@ExAmpLE.com'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?(' ')
  end
end
