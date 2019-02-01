class UsersController < ApplicationController
    # before_action :require_no_user!

    def create
        @user = User.new(user_params)

        if @user.save
            login_user!(@user)
            redirect_to user_url(@user)         
        else
            flash.now[:errors] = @user.errors.full_messages
            # render :new
            redirect_to new_session_url
        end
    end

    def new
        @user = User.new
        render :new
    end

    def show
        render :show
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end