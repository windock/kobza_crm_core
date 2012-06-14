require 'kobza_crm/person'
require 'mongobzar'

module KobzaCRM
  module Persistence
    class MongoPersonRepository
      class AddressMapper < Mongobzar::Mapping::EmbeddedMapper

        def build_dto!(dto, address)
          if address.kind_of?(EmailAddress)
            dto['email_address'] = address.email_address
            dto['type'] = 'email'
          elsif address.kind_of?(WebPageAddress)
            dto['url'] = address.url
            dto['type'] = 'web_page'
          end
        end
      end

      class PersonMapper < Mongobzar::Mapping::Mapper
        def initialize(database_name)
          super
          set_mongo_collection('people')
          @address_mapper = AddressMapper.new
        end

        def build_dto!(dto, person)
          dto['name'] = person.name
          dto['addresses'] = @address_mapper.build_embedded_collection(
            person.addresses
          )
        end
      end

      def initialize(id_generator, database_name)
        @database_name = database_name
        @mapper = PersonMapper.new(@database_name)
      end

      def add(domain_object)
        @mapper.insert(domain_object)
      end

      def clear_everything!
        @mapper.clear_everything!
      end
    end
  end
end
