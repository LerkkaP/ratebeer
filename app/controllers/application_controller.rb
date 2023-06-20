class ApplicationController < ActionController::Base

    helper_method :current_user

    def current_user
      return nil if session[:user_id].nil?
      user = User.find_by(id: session[:user_id])
      return user if user.present?
    
      session[:user_id] = nil
      nil
    end    
end


