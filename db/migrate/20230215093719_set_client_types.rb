class SetClientTypes < ActiveRecord::Migration[6.1]
  def up
    @clients = Client.all
    @clients.each do |client|
      if client.factures.size != 0
        client.prestation_hypnose = true
      else
        client.prestation_ux = true
      end
      client.save
    end
  end
end
