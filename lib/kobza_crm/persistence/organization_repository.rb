require 'kobza_crm/organization'
require 'kobza_crm/persistence/party_repository'

module KobzaCRM
  module Persistence
    class OrganizationMapper < PartyMapper
      include NoPublicNew

      def build_new(dto)
        Organization.new(dto['name'])
      end
    end

    class OrganizationRepository < PartyRepository
      def mapper
        OrganizationMapper.instance(
          address_mapper, role_repository)
      end

      def mongo_collection_name
        'organizations'
      end
    end
  end
end
