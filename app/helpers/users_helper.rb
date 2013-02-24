module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 100 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar dropshadow")
  end

  def name_of_user(id)
    user=User.find(id)
    "#{user.name}"
  end

  def first_name(user)
    first_name=user.name.split(/\W+/).first
    "#{first_name.titleize}"
  end

end
