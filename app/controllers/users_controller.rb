class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @workorders = @user.workorders.wo_not_completed.paginate(page: params[:page], :per_page => 5)
    @completed_workorders = @user.workorders.wo_completed.descending.paginate(page: params[:page], :per_page => 5)
  end

  def index
    if current_user.admin?
      @users = User.active.order('current_branch, name')
      @inactive_users = User.inactive.order('current_branch, name')
    end
    if current_user.super_user? && !current_user.admin?
      @users = User.active_by_branch(current_user.current_branch).sort_by &:name
      @inactive_users = User.inactive_by_branch(current_user.current_branch).sort_by &:name
    end
  end

  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
  end

  def new
    if signed_in?
      if current_user.admin? || current_user.super_user?
        @user = User.new
      end
    else
      redirect_to root_path, :error => "New users can only be created by an administrators."
    end
  end

  def create
    @user = User.new(params[:user])
      if @user.save
        redirect_to root_path
      else
        render 'new'
    end
  end

  def edit
      @user = User.find(params[:id])
  end

  def user_branch_switch
      @user = User.find(current_user)
  end

  def update
        @user = User.find(params[:id])
        @admin= User.find(current_user)
        if @user.update_attributes(params[:user])
          flash[:success] = "Profile updated"
          if (current_user.admin? && @user != current_user) || (current_user.super_user? && @user != current_user)
            redirect_to users_path
          else
            sign_in @user
            redirect_to root_path
          end
        else
          render 'edit'
      end
  end

    private

      def correct_user
        @user=User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user) ||
                                      current_user.admin?  ||
                                      current_user.super_user?
      end
      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end
  end
