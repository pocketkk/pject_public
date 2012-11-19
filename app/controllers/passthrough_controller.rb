class PassthroughController < ApplicationController

  def index
    path=welcome_path
    flash.keep
    unless current_user.nil?
        path = case current_user.role
              when 'Regional Manager'
                branchmanager_path
              when 'Branch Manager'
                branchmanager_path
              when 'Sales'
                branchmanager_path
              when 'Rebuilder'
                branchmanager_path
              else
                path = branchmanager_path
              end

      end
      redirect_to path

  end


end
