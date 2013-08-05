class TasksController < ApplicationController

  before_filter :load_taskable, :except => [:update, :change_context, :edit]

  def index
    @tasks = @taskable.tasks
  end

  def new
    @task = @taskable.tasks.new
  end

  def edit
    @task = Task.find(params[:id])
    @taskable=current_user
    @users = User.active_by_branch(current_user.current_branch)
  end

  def create
    @task = current_user.tasks.new(params[:task])
    @task.completed=false
    @task.save
    session[:return_to] ||= request.referer
    respond_to do |format|
      format.html { redirect_to session[:return_to], notice: "Task created." }
      format.js
    end
  end

  def destroy
    @task = Task.destroy(params[:id])
    respond_to do |format|
      format.html {redirect_to root_path, :notice => "Task Removed."}
      format.mobile
      format.js
    end
  end

  def show
    @task = Task.find(params[:id])
  end

def update
    @task = Task.find(params[:id])
    @task.update_attributes!(params[:task])
    respond_to do |format|
      format.mobile { redirect_to root_path}
      format.html { redirect_to root_path }
      format.js
    end
end

def change_context
  session[:context] = params[:context]
  redirect_to root_path
end

private

  def load_taskable
    resource, id = request.path.split('/')[1, 2]
    @taskable = resource.singularize.classify.constantize.find(id)
  end

  # alternative option:
  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end
