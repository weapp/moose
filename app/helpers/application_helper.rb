module ApplicationHelper
  def mkd
    @mkd ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end

  def gravatar_for(user, options={size:50})
    gravatar_image_tag user.try(:email).try(:downcase), alt: user.try(:username), class: 'gravatar', gravatar: options
  end

  def icon_for(row, options={size:16})
    file = "icon#{options[:size]}/#{row.attachment_content_type.gsub('/','-')}.png"
    if Rails.application.assets.find_asset file
      image_tag file
    else
      image_tag "paper-clip.png"
    end
  end
end
