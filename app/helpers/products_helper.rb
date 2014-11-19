module ProductsHelper
  def round b
  	(b * 100).to_i / 100.0
  end

  def truncate_text description
    output = h truncate(description.description, length: 200, omission: '...')
    output += link_to('Read More', boken_path(description)) if description.description.size > 200
    output.html_safe
  end
end
