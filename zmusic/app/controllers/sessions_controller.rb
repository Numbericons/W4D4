class SessionsController < ApplicationController
    # before_action: require_no_user!, only: %i(create new)
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )
        # fail
        if user.nil?
            flash.now[:errors] = ["Incorrect username/password combination"]
            render :new
        else
            login_user!(user)
            redirect_to user_url(user)
        end
    end

    def destroy
        # return nil unless current_user
        current_user.reset_session_token!
        session[:session_token] = nil
        
        redirect_to new_session_url
    end
end