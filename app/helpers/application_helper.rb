module ApplicationHelper
  def active_link_to(name, options, html_options = {})
    html_options[:wrap_tag] = 'li'
    html_options[:active] = :exclusive
    super(name, options, html_options)
  end
end
