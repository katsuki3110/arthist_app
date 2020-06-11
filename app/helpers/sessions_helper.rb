module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    current_user.present?
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
  end

end
