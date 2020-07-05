module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])
      #ログインしているならば
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      #cookiesに保存しているならば
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  def logged_in?
    current_user.present?
  end

  def forget(user)
    user.forget
    cookies[:user_id] = nil
    cookies[:remember_token] = nil
  end

  def logout
    forget(current_user)
    session[:user_id] = nil
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


end
