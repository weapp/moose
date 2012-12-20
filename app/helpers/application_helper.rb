module ApplicationHelper
  def mkd
    @mkd ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end

  def gravatar_for(user, options={size:50})
    gravatar_image_tag user.email.downcase, alt: user.username, class: 'gravatar', gravatar: options
  end

end
