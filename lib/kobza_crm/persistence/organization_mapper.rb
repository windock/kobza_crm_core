require 'kobza_crm/domain/organization'
require 'kobza_crm/persistence/party_mapper'
require 'kobza_crm/no_public_new'

module KobzaCRM
  module Persistence
    class OrganizationMapper < PartyMapper
      include NoPublicNew

      def self.instance(address_mapper, role_mapper)
        Mongobzar::Mapper::EntityMapper.new(new(address_mapper, role_mapper))
      end

      def build_new(dto)
        Domain::Organization.new(dto['name'])
      end
    end
  end
end
