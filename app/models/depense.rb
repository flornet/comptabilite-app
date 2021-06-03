class Depense < ApplicationRecord
  validates :libelle,  :presence => true
  validates :montant_ttc, :presence => true
  belongs_to :user

  def has_justificatif
    if self.justificatif_nom != nil && self.justificatif_type_contenu != nil && self.justificatif_data != nil
       return true
    end
    return false
  end

  def justificatif=(incoming_file)
    if incoming_file != nil
      self.justificatif_nom = incoming_file.original_filename
      self.justificatif_type_contenu = incoming_file.content_type
      self.justificatif_data = incoming_file.read
    else
      self.justificatif_nom = nil
      self.justificatif_type_contenu = nil
      self.justificatif_data = nil
    end
  end

  def justificatif_nom=(new_filename)
    if new_filename != nil
      write_attribute("justificatif_nom", sanitize_filename(new_filename))
    end
  end

  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
