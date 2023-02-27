class TasksController < ApplicationController
  before_action :set_task,only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "タスクを登録しました"
      else
        render :new, notice: "登録できませんでした"
      end
    end
  end

  def show
  end

  def edit
 
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "タスクを編集しました." 
    else
      render :edit, notice: "編集できませんでした"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :detail)
  end

end
