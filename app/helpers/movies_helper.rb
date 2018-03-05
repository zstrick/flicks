module MoviesHelper
  def format_total_gross(movie)
    if movie.flop?
      content_tag(:strong, "Flop!")
    else
      number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag 'placeholder.png', class: "img-thumbnail float-left mr-3 mb-3"
    else
      image_tag movie.image_file_name, class: "img-thumbnail float-left mr-3 mb-3"
    end
  end
end
