class StaticPagesController < ApplicationController
  def home
     @workorder = current_user.workorders.build if signed_in?
     @workorders = current_user.workorders.paginate(page: params[:page])
     
   end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
