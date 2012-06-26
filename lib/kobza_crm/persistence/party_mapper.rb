require 'mongobzar'
require 'kobza_crm/persistence/address_mapper'
require 'kobza_crm/persistence/role_mapper'
require 'kobza_crm/persistence/mapping_strategy'

module KobzaCRM
  module Persistence
    class PartyMapper < Mongobzar::Mapping::Mapper
      class PartyMappingStrategy < MappingStrategy
        def initialize(address_mapper, role_mapper)
          @address_mapper = address_mapper
          @role_mapper = role_mapper
        end

        def build_domain_object!(party, dto)
          @address_mapper.build_domain_objects(dto['addresses']).each do |address|
            party.add_address(address)
          end

          @role_mapper.find_dependent_collection(party).each do|role|
            party.add_role(role)
          end
        end

        def build_dto!(dto, party)
          dto['name'] = party.name

          dto['addresses'] = @address_mapper.build_embedded_collection(
            party.addresses
          )
        end
      end

      def initialize(database_name)
        super
        @address_mapper = AddressMapper.instance
        @role_mapper = RoleMapper.instance(database_name)
        @mapping_strategy = PartyMappingStrategy.new(@address_mapper, @role_mapper)
      end

      def build_dto!(dto, party)
        @mapping_strategy.build_dto!(dto, party)
      end

      def insert(party)
        super
        @role_mapper.insert_dependent_collection(party, party.roles)
      end

      def update(party)
        super
        @role_mapper.update_dependent_collection(party, party.roles)
      end

      def build_domain_object!(party, dto)
        @mapping_strategy.build_domain_object!(party, dto)
      end

      def clear_everything!
        super
        @role_mapper.clear_everything!
      end
    end
  end
end
