require 'kobza_crm/domain/person'
require 'kobza_crm/no_public_new'
require 'kobza_crm/persistence/party_mapper'

module KobzaCRM
  module Persistence
    class PersonMapper < PartyMapper
      include NoPublicNew

      def self.instance(address_mapper, role_mapper)
        Mongobzar::Mapper::EntityMapper.new(new(address_mapper, role_mapper))
      end

      def build_new(dto)
        Person.new(dto['name'])
      end
    end
  end
end
