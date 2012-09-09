class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  def show
    @user = User.find(params[:id])
    @workorders = @user.workorders.paginate(page: params[:page])
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
  end
  
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to Pject.us"
        redirect_to @user
      else
        render 'new'
    end
  end
  def edit
      @user = User.find(params[:id])
  end
  def update
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user]) || current_user.admin?
          flash[:success] = "Profile updated"
          if @user=current_user  
            sign_in @user
            redirect_to @user
          end
        else
          render 'edit'
      end
  end
=begin
  TODO 
  -Change redirect after admin edits a users account
  -Remove password from updated fields when edited by admin
=end    
    private
   
      def correct_user
        @user=User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user) || current_user.admin?
      end
      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end
  end