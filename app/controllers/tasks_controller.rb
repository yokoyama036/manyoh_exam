class TasksController < ApplicationController
  before_action :set_task,only: %i[ show edit update destroy ]

  def index
     @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
     if params[:task].present?
      if params[:task][:name_search].present? && params[:task][:status].present?
        @tasks = Task.where('task_name LIKE ?', "%#{params[:task][:name_search]}%").where(status: params[:task][:status])
        # @tasks = Task.where('task_name LIKE ? AND status = ?', "%#{params[:task][:name_search]}%,",params[:task][:status])
        #↑この書き方だとログ上は実行されたように見えるが中身は[]で検索対象なしとなる
        @tasks = @tasks.page(params[:page]).per(10)
      elsif  params[:task][:name_search].present?
        @tasks = Task.where('task_name LIKE ?', "%#{params[:task][:name_search]}%")
        @tasks = @tasks.page(params[:page]).per(10)
      elsif  params[:task][:status].present?
        @tasks = Task.where(status: params[:task][:status])
        @tasks = @tasks.page(params[:page]).per(10)
      end
     end
    if params[:sort_deadline]
      @tasks = Task.all.order(deadline: :asc)
      @tasks = @tasks.page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :asc)
      @tasks = @tasks.page(params[:page]).per(10)
    end
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
    params.require(:task).permit(:task_name, :detail, :deadline, :status, :priority)
  end

end
