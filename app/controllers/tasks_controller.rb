class TasksController < ApplicationController
#This controller will inherit from the ApplicationController and will be the most basic form of controller in this app

    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end

    def show
        @task = Task.find(params[:id])
    end

    def create
        @task = Task.new(task_params)

        #Temporary
        @task.user_id = current_user.id

        if @task.save
            flash[:notice] = "Task successfully created!"
            redirect_to task_path(@task)
        else
            flash[:danger] = @task.errors.full_messages
            redirect_to new_task_path
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def destroy
        @task = Task.find(params[:id])
        if current_user == @task.user
            if not @task.destroy
                flash[:danger] = "Item could not be deleted!"
            end
        else
            flash[:danger] = "You don't have the rights to delete this item!"
        end

        redirect_to tasks_path
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:notice] = "Item was updated!"
            redirect_to task_path(@task)
        else
           flash[:danger] = "Item could not be updated!"
           redirect_to edit_task_path
        end
    end

    private
        def task_params
            params.require(:task).permit(:name, :description, :effort, :priority)
        end
end