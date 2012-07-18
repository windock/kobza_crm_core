require 'kobza_crm/domain/organization'
require 'kobza_crm/persistence/mongo/party_assembler'

module KobzaCRM module Persistence module Mongo
  class OrganizationAssembler < PartyAssembler
    def self.instance(address_assembler, role_assembler)
      Mongobzar::Assembler::EntityAssembler.new(new(address_assembler, role_assembler))
    end

    def build_new(dto)
      Domain::Organization.new(dto['name'])
    end
  end
end end end
