class TasksController < ApplicationController
 before_action :require_user_logged_in
 before_action :correct_user, only: [:destroy, :show, :update, :edit]
  
  def new
    @task = Task.new
  end
  
  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end
    
  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def show
  end
  
  def create
     @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.feed_tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_to root_path
  end

   def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
   end

  private

  def task_params
    params.require(:task).permit(:status, :content)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end