class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_user, :user_is_author?, :user_is_author_redirect

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to tasks_path
    end
  end

  def user_is_author? (user)
    current_user == user
  end

  def user_is_author_redirect (user)
    if !user_is_author?(user)
      flash[:danger] = "You don't have permission to edit this page"
      redirect_to tasks_path
    end
  end

end
