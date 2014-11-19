module WelcomeHelper
  def round b
  	(b * 100).to_i / 100.0
  end

  def truncate_text description
    output = h truncate(description.description, length: 100, omission: '...')
    output += link_to('Read More', product_path(description)) if description.description.size > 100
    output.html_safe
  end
end
