class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user_if_none

  def authenticate_user_if_none
    unless params[:controller].match(/devise/)
      if current_user.blank?
        redirect_to new_user_session_path
      end
    end
  end
end
