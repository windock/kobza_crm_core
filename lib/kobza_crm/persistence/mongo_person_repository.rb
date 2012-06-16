require 'kobza_crm/person'
require 'kobza_crm/persistence/party_mapper'
require 'kobza_crm/persistence/mongo_repository'

module KobzaCRM
  module Persistence
    class MongoPersonRepository < MongoRepository
      class PersonMapper < PartyMapper
        def initialize(database_name)
          super
          set_mongo_collection('people')
        end

        def build_new(dto={})
          Person.new(dto['name'])
        end
      end

      def initialize(id_generator, database_name)
        super()
        @mapper = PersonMapper.new(database_name)
        @mapper.id_generator = id_generator
      end
    end
  end
end
