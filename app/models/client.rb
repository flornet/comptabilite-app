class Client < ApplicationRecord
  has_paper_trail

  belongs_to :taxe
  belongs_to :user
  has_many :factures
  has_many :devis

  validates :nom,  :presence => true
  validates :nom, uniqueness: { case_sensitive: false }

  after_save :test

  scope :filtered, ->(query_params) { Client::Filter.new.filter(self, query_params) }

  def test
    Rails.logger.debug('---------------CLIENT (after save)--------------')
    Rails.logger.debug(self.updated_at)
    Rails.logger.debug('-------------------------------------------------')
    #date_version_client
  end
end
