require 'kobza_crm/person'
require 'kobza_crm/persistence/party_mapper'
require 'kobza_crm/persistence/mongo_repository'

module KobzaCRM
  module Persistence
    class MongoPersonRepository < MongoRepository
      class PersonMappingStrategy < PartyMappingStrategy
        include NoPublicNew

        def build_new(dto)
          Person.new(dto['name'])
        end
      end

      class PersonMapper < PartyMapper
        def mapping_strategy
          PersonMappingStrategy.instance(
            address_mapping_strategy, role_mapper)
        end

        def mongo_collection_name
          'people'
        end
      end

      def initialize(database_name)
        super()
        @database_name = database_name
      end

      protected
        def mapper
          PersonMapper.new(database_name)
        end

      private
        attr_reader :database_name
    end
  end
end
