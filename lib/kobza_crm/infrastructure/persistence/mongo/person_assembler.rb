require 'kobza_crm/domain/person'
require 'kobza_crm/infrastructure/persistence/mongo/party_assembler'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class PersonAssembler < PartyAssembler
    def build_new(dto)
      Domain::Person.new(dto['name'])
    end
  end
end end end end
