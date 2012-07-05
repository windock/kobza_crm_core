require 'kobza_crm/person'
require 'kobza_crm/persistence/party_repository'

module KobzaCRM
  module Persistence
    class PersonMapper < PartyMapper
      include NoPublicNew

      def build_new(dto)
        Person.new(dto['name'])
      end
    end

    class PersonRepository < PartyRepository
      def mapper
        PersonMapper.instance(
          address_mapper, role_repository)
      end

      def mongo_collection_name
        'people'
      end
    end

  end
end
