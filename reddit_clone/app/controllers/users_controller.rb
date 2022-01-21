class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def show
        render :show
    end

    def create
        @user = User.new(user_params)

        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            flash.new[:error] = @user.errors.full_messages
            render :new
        end
    end

    

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end
