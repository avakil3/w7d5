class SubsController < ApplicationController
    before_action :ensure_logged_in

    def new
        @sub = Sub.new
        render :new
    end

    def show
        @sub = Sub.find(params[:id])
        render :show
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.user_id  = current_user.id

        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def edit
        @sub = Sub.find(params[:id])

        if @sub.moderator == current_user
            render :edit
        else
            flash.now[:error] = ["Current user is not the moderator"]
        end

    end


    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end
