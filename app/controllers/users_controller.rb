class UsersController < ApplicationController
    #This controller will inherit from the ApplicationController and will be the most basic form of controller in this app
    
        def index
            @users = User.all
        end
    
        def new
            @user = User.new
        end
    
        def show
            @user = User.find(params[:id])
        end
    
        def create
            @user = User.new(user_params)
            if @user.save
                redirect_to user_path(@user)
                flash[:notice] = "User successfully created!"
                session[:user_id] = @user.id
            else
                flash[:danger] = @user.errors.full_messages
                redirect_to new_user_path
            end
        end
    
        def edit
            @user = User.find(params[:id])
        end
    
        def destroy
            @user = User.find(params[:id])

            if current_user == @user
                tasks = Task.all
                tasks.each do |task|
                    if task.user_id = @user.id
                        task.destroy
                    end
                end

                if not @user.destroy
                    flash[:danger] = "User could not be deleted!"
                else
                    flash[:notice] = "User was deleted"
                    session[:user_id] = nil
                end
            else
                flash[:danger] = "You don't have rights to delete another user!"
            end
            redirect_to users_path
        end
    
        def update
            @user = User.find(params[:id])
            if @user.update(user_params)
                flash[:notice] = "User was updated!"
                redirect_to user_path(@user)
            else
               flash[:notice] = "User could not be updated!"
               redirect_to edit_user_path
            end
        end
    
        private
            def user_params
                params.require(:user).permit(:name, :email, :password)
            end
    end