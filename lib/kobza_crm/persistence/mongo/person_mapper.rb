require 'kobza_crm/domain/person'
require 'kobza_crm/no_public_new'
require 'kobza_crm/persistence/mongo/party_mapper'

module KobzaCRM module Persistence module Mongo
  class PersonMapper < PartyMapper
    include NoPublicNew

    def self.instance(address_mapper, role_mapper)
      Mongobzar::Mapper::EntityMapper.new(new(address_mapper, role_mapper))
    end

    def build_new(dto)
      Domain::Person.new(dto['name'])
    end
  end
end end end
