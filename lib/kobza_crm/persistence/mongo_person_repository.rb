require 'kobza_crm/person'
require 'kobza_crm/persistence/party_mapper'
require 'kobza_crm/persistence/mongo_repository'

module KobzaCRM
  module Persistence
    class MongoPersonRepository < MongoRepository
      class PersonMappingStrategy < PartyMappingStrategy
        def build_new(dto)
          Person.new(dto['name'])
        end
      end

      class PersonMapper < PartyMapper
        def initialize(database_name)
          super
          @mapping_strategy = PersonMappingStrategy.new(
            address_mapping_strategy, role_mapper)
        end

        def mongo_collection_name
          'people'
        end
      end

      def initialize(id_generator, database_name)
        super()
        @mapper = PersonMapper.new(database_name)
      end
    end
  end
end
