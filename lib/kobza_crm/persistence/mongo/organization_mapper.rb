require 'kobza_crm/domain/organization'
require 'kobza_crm/persistence/mongo/party_mapper'
require 'kobza_crm/no_public_new'

module KobzaCRM
  module Persistence
    module Mongo
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
end
