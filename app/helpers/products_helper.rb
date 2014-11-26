module ProductsHelper
  def round(b)
    (b * 100).to_i / 100.0
  end

  def truncate_text(description)
    output = h truncate(description.description, length: 200, omission: '...')
    if description.description.size > 200
      output += link_to('Read More', boken_path(description))
    end
    output.html_safe
  end

  def percentage(percent)
    sprintf('%.2f%', percent * 100)
  end
end
