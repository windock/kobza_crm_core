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

        def build_new(dto={})
          if dto['type'] == 'web_page'
            WebPageAddress.new(dto['url'])
          elsif dto['type'] == 'email'
            EmailAddress.new(dto['email_address'])
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

        def build_new(dto={})
          Person.new(dto['name'])
        end

        def build_domain_object!(person, dto)
          @address_mapper.build_domain_objects(dto['addresses']).each do |address|
            person.add_address(address)
          end
        end
      end

      def initialize(id_generator, database_name)
        @database_name = database_name
        @mapper = PersonMapper.new(@database_name)
        @mapper.id_generator = id_generator
      end

      def add(domain_object)
        @mapper.insert(domain_object)
      end

      def find(id)
        @mapper.find(id)
      end

      def all
        @mapper.all
      end

      def clear_everything!
        @mapper.clear_everything!
      end
    end
  end
end
