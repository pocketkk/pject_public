module Followable
  extend ActiveSupport::Concern

    def add_follower(user)
      self.followers.create(user_id: user.id) unless already_following?(user)
    end

    def remove_follower(user)
      followers.each do |follower|
        if follower.user_id == user.id
          follower.destroy
        end
      end
    end

    def already_following?(user)
      is_following=false
      followers.each do |follower|
        if follower.user_id == user.id
          is_following=true
        end
       end
      is_following
    end

    def unique_follower?(user)
     unique=true
     followers.each do |follower|
       if follower.user_id == user.id
         unique=false
       end
     end
     unique
    end

    def toggle_follower(user)
        if already_following?(user)
            remove_follower(user)
        else
            add_follower(user)
        end
    end


end
