module ApplicationHelper
  def mkd
    @mkd ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end
end
