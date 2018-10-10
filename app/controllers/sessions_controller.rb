class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:session][:email])
        puts user
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            session[:user_id] = nil
            flash.now[:danger] = "There was an error with your email/password"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have been logged out"
        redirect_to root_path
    end
end