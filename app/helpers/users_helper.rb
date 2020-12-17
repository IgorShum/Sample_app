module UsersHelper
  def gravatar_for_user(user, options={ size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def hide_email(email)
    hidemail = email.chars
    hidemail[2,3] = '*'
    hidemail.join()
  end
end
