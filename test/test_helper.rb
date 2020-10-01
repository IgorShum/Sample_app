ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, options={})
    email = options [:email] || 'example@ex.com'
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    user_params = { email: email, password: password, remember_me: remember_me}
    post login_path, params: { session: user_params }
  end

  # Add more helper methods to be used by all tests here...
end
