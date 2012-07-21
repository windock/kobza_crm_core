require 'kobza_crm/domain/organization'
require 'kobza_crm/infrastructure/persistence/mongo/party_assembler'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class OrganizationAssembler < PartyAssembler
    def build_new(dto)
      Domain::Organization.new(dto['name'])
    end
  end
end end end end
