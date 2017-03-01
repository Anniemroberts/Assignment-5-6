class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authorize
  #
  # def authorize
  #   head :unauthorized unless current_user.is_admin?
  # end

  def authenticate_user!
    redirect_to new_session_path, alert: 'please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    User.find session[:user_id] if user_signed_in?
  end
  helper_method :current_user
  #adding the line above makes this method available in every view file.
  def full_name
    "#{current_user.first_name} #{current_user.last_name}".strip.titleize
  end
  helper_method :full_name
end
