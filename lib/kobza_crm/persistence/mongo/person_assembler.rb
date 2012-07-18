require 'kobza_crm/domain/person'
require 'kobza_crm/persistence/mongo/party_assembler'

module KobzaCRM module Persistence module Mongo
  class PersonAssembler < PartyAssembler
    def self.instance(address_assembler, role_assembler)
      Mongobzar::Assembler::EntityAssembler.new(new(address_assembler, role_assembler))
    end

    def build_new(dto)
      Domain::Person.new(dto['name'])
    end
  end
end end end
