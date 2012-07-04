require 'kobza_crm/organization'
require 'kobza_crm/persistence/party_mapper'

module KobzaCRM
  module Persistence
    class OrganizationMappingStrategy < PartyMappingStrategy
      include NoPublicNew

      def build_new(dto)
        Organization.new(dto['name'])
      end
    end

    class OrganizationMapper < PartyMapper
      def mapping_strategy
        OrganizationMappingStrategy.instance(
          address_mapping_strategy, role_mapper)
      end

      def mongo_collection_name
        'organizations'
      end
    end
  end
end
