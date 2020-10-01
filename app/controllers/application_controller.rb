class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :log_in_as, :is_logged_in, :session, :remember_token
end
