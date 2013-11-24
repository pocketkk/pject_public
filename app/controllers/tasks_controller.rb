class TasksController < ApplicationController

  before_filter :load_taskable, :except => [:create, :update, :change_context, :edit]

  def index
    @tasks = @taskable.tasks
  end

  def new
    @task = @taskable.tasks.new
  end

  def edit
    @task = Task.find(params[:id])
    @taskable=current_user
    @users = user_roster
  end

  def create
    @task = current_user.tasks.new(params[:task])
    @task.completed=false
    if @task.save
      @task.followers_as_users.each do |user|
        if user.receive_mails == true
          PdfMailer.mail_task(@task,user,"New").deliver
        end
      end
      if @task.assigned_to
        user=User.find(@task.assigned_to)
        if user.receive_mails == true && @task.taskable != user
          PdfMailer.mail_task(@task,user,"New").deliver
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Task created." }
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
    if @task.update_attributes!(params[:task])
      if params[:task][:completed] == true
        @task.followers_as_users.each do |user|
          if user.receive_mails == true
            PdfMailer.mail_task(@task,user,"Completed").deliver
          end
        end
        if @task.assigned_to
          user=User.find(@task.assigned_to)
          if user.receive_mails == true
            PdfMailer.mail_task(@task,user,"Completed").deliver
          end
        end
        if @task.taskable.receive_mails == true
          PdfMailer.mail_task(@task,user,"Completed").deliver
        end
      end
      respond_to do |format|
        format.mobile { redirect_to root_path}
        format.html { redirect_to root_path }
        format.js
      end
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
