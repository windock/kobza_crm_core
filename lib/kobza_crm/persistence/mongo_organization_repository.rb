require 'kobza_crm/organization'
require 'kobza_crm/persistence/party_mapper'
require 'kobza_crm/persistence/mongo_repository'

module KobzaCRM
  module Persistence
    class MongoOrganizationRepository < MongoRepository
      class OrganizationMappingStrategy < PartyMappingStrategy
        def build_new(dto)
          Organization.new(dto['name'])
        end
      end

      class OrganizationMapper < PartyMapper
        def initialize(database_name)
          super
          @mapping_strategy = OrganizationMappingStrategy.new(
            address_mapping_strategy, role_mapper)
        end

        def mongo_collection_name
          'organizations'
        end
      end

      def initialize(id_generator, database_name)
        super()
        @mapper = OrganizationMapper.new(database_name)
      end
    end
  end
end
