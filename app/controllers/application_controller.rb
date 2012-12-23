class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :yt_client, :comment_update
  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end

  def comment_update( commentable_object, commentable_comment )
    @update=current_user.updates.new
        if commentable_object.kind_of?(Workorder)
            commenter=User.find(current_user)
            @update.feed_item=current_user.name << " commented on " << commentable_object.customer.titleize << "'s workorder.  \" " << commentable_comment << " \""

            #Find users involved in workorder
            workorder=Workorder.find(commentable_object.id)
            installer=User.find(workorder.assigned_to) unless workorder.assigned_to.blank?
            sales=User.find(workorder.user)


            users_to_email=User.find(:all, :conditions=>['current_branch=? and receive_mails=? and role=?',current_user.current_branch, true, 'Branch Manager' || 'Regional Manager' || 'Rebuilder'])

            #Email Users
            users_to_email.each do |user|
              unless user.blank?
                  PdfMailer.mail_comment(workorder,user,commentable_comment,commenter).deliver
              end
            end

            PdfMailer.mail_comment(workorder,installer,commentable_comment,commenter).deliver unless installer.nil? || installer.role=='Branch Manager' || 'Regional Manager' || 'Rebuilder'
            PdfMailer.mail_comment(workorder,sales,commentable_comment,commenter).deliver unless sales.nil? || sales.role=='Branch Manager' || 'Regional Manager' || 'Rebuilder'

        end
        if commentable_object.kind_of?(Document)
            @update.feed_item=current_user.name << " commented on " << commentable_object.description.titleize << " document.  \" " << commentable_comment << " \""
        end
        if commentable_object.kind_of?(Video)
            @update.feed_item=current_user.name << " commented on " << commentable_object.title.titleize << " video.  \" " << commentable_comment << " \""
        end
        if commentable_object.kind_of?(Post)
            @update.feed_item=current_user.name << " commented on " << commentable_object.title.titleize << " blog post.  \" " << commentable_comment << " \""
        end
    @update.save
  end


  include SessionsHelper


end
