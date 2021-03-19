module ApplicationHelper
  def montant_humanise(nombre)
    number_to_currency(nombre, unit: "€", separator: ",", delimiter: " ", format: "%n %u", negative_format: "- %n %u")
  end

  def back_link_to_root()
    output = ''
    output += '<div class="navbar-item">'
    output += '<a href="' + url_for(root_path) + '" class="button">'
    output += '<span class="icon"><i class="fa fa-chevron-left"></i></span>'
    output += "<span>Revenir à l'accueil</span>"
    output += '</a>'
    output += '</div>'
    output.html_safe
  end

  def back_link_to(path)
    output = ''
    output += '<div class="navbar-item">'
    output += '<a href="' + url_for(path) + '" class="button">'
    output += '<span class="icon"><i class="fa fa-chevron-left"></i></span>'
    output += '<span>Revenir à la liste</span>'
    output += '</a>'
    output += '</div>'
    output.html_safe
  end

  def page_title(title)
    output = ''
    output += '<div class="navbar-brand">'
    output += '<h1 class="navbar-item title is-4">' + title + '</h1>'
    output += '</div>'
    output.html_safe
  end

  def current_page_active_class?(test_path)
    if request.path == test_path
      'is-active'
    elsif request.path.starts_with?(test_path) && test_path != root_path
      'is-active'
    else
      ''
    end
  end

end
