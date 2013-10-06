class ApplicationController < ActionController::Base
  include Mobylette::RespondToMobileRequests
  include SessionsHelper

  mobylette_config do |config|
    config[:skip_user_agents] = [:ipad]
  end

  protect_from_forgery
  # before_filter :miniprofiler
  helper_method :yt_client, :comment_update

  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end

  def comment_update( commentable_object, commentable_comment )

        if commentable_object.kind_of?(Workorder)
            commenter=User.find(current_user)

            message=current_user.name.titleize + " commented on " + commentable_object.customer.titleize + "'s workorder. - \" " + commentable_comment + " \""
            Updater.new(commentable_comment, update_type: new, message: message, user: current_user)

            #Find users involved in workorder
            workorder=Workorder.find(commentable_object.id)
            installer=User.find(workorder.assigned_to) unless workorder.assigned_to.blank?
            sales=User.find(workorder.user)

            users_to_email=User.find(:all, :conditions=>['current_branch=? and receive_mails=? and role=?',
                current_user.current_branch, true, 'Branch Manager' || 'Regional Manager' || 'Rebuilder'])

            #Email Users
            users_to_email.each do |user|
              unless user.blank?
                  PdfMailer.mail_comment(workorder,user,commentable_comment,commenter).deliver
              end
            end

            PdfMailer.mail_comment(workorder,installer,commentable_comment,commenter).deliver unless installer.nil? ||
                installer.role=='Branch Manager' || installer.role=='Regional Manager' || installer.role=='Rebuilder'
            PdfMailer.mail_comment(workorder,sales,commentable_comment,commenter).deliver unless sales.nil? ||
                sales.role=='Branch Manager' || sales.role=='Regional Manager' || sales.role=='Rebuilder'

        end
        if commentable_object.kind_of?(Document)
            message=current_user.name.titleize << " commented on " << commentable_object.description.titleize << " document. - \" " << commentable_comment << " \""
            Updater.new(commentable_comment, update_type: new, message: message, user: current_user)
        end
        if commentable_object.kind_of?(Video)
            message=current_user.name.titleize << " commented on " << commentable_object.title.titleize << " video. - \" " << commentable_comment << " \""
            Updater.new(commentable_comment, update_type: new, message: message, user: current_user)
        end
        if commentable_object.kind_of?(Post)
            message=current_user.name.titleize << " commented on " << commentable_object.title.titleize << " blog post. - \" " << commentable_comment << " \""
            Updater.new(commentable_comment, update_type: new, message: message, user: current_user)
        end

  end


private
# def miniprofiler
#   Rack::MiniProfiler.authorize_request if current_user.admin?
# end




end
