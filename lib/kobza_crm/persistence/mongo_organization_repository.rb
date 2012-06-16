require 'kobza_crm/organization'
require 'kobza_crm/persistence/party_mapper'
require 'kobza_crm/persistence/mongo_repository'

module KobzaCRM
  module Persistence
    class MongoOrganizationRepository < MongoRepository
      class OrganizationMapper < PartyMapper
        def mongo_collection_name
          'organizations'
        end

        def build_new(dto={})
          Organization.new(dto['name'])
        end
      end

      def initialize(id_generator, database_name)
        super()
        @mapper = OrganizationMapper.new(database_name)
        @mapper.id_generator = id_generator
      end
    end
  end
end
