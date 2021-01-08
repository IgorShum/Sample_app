class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  include SessionsHelper
  helper_method :log_in_as, :is_logged_in, :session, :remember_token

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please, Log in."
      redirect_to login_url
    end
  end
end
