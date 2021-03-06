module ProductsHelper
  def truncate_text(description)
    output = h truncate(description.description, length: 200, omission: '...')
    if description.description.size > 200
      output += link_to('Read More', boken_path(description))
    end
    output.html_safe
  end
end
