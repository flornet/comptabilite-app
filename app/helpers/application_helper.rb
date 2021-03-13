module ApplicationHelper
  def montant_humanise(nombre)
    number_to_currency(nombre, unit: "€", separator: ",", delimiter: " ", format: "%n %u", negative_format: "- %n %u")
  end
end
