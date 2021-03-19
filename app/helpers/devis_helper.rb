module DevisHelper
  # This method creates a link with `data-id` `data-fields` attributes. These attributes are used to create new instances of the nested fields through Javascript.
  def link_to_add_devis_line(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render('devis/partials/' + association.to_s.singularize + "_fields_form", f: builder)
      end
      link_to(name, '#', class: "add_fields button", data: {id: id, fields: fields.gsub("\n", "")})

  end

  def links_to_choose_devis_model(models, default_model)
    output = ""
    models.each do |modele|
      css_class = "button"
      if default_model == modele
        css_class += " is-active"
      end
      output += '<p class="control">'
      output += link_to(modele.nom, new_devi_path(:with_model => modele.id), class: css_class)
      output += '</p>'
    end
    output.html_safe
  end

  def date_pour_devis(devi)

    output = ""
    output += "<div class='is-size-5'>" + devi.date.strftime("%d") + '</div>'
    output += "<div class='is-size-7'>" + devi.date.strftime("%^b.")
    output += devi.date.strftime(" %y") unless devi.date.year == Date.today.year
    output += '</div>'
    # devi.date.strftime("%d")
    output.html_safe
  end

  def numero_pour_devis(devi)
    "N°#{devi.numero}"
  end

  def statut_pour_devis(devi)
    render "devis/partials/devis_statut_selecteur", devi: devi
  end

end
