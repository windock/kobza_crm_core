require 'mongobzar'
require 'kobza_crm/persistence/address_mapper'
require 'kobza_crm/persistence/role_mapper'

module KobzaCRM
  module Persistence
    class PartyMappingStrategy < Mongobzar::MappingStrategy::EntityMappingStrategy
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

        dto['addresses'] = @address_mapper.build_dtos(
          party.addresses
        )
      end
    end

    class PartyMapper < Mongobzar::Mapping::Mapper
      attr_reader :mapping_strategy
      attr_reader :role_mapper

      def initialize(database_name)
        super
        @address_mapper = AddressMapper.instance
        @role_mapper = RoleMapper.instance(database_name)
      end

      def insert(party)
        super
        role_mapper.insert_dependent_collection(party, party.roles)
      end

      def update(party)
        super
        role_mapper.update_dependent_collection(party, party.roles)
      end

      def clear_everything!
        super
        role_mapper.clear_everything!
      end

      protected
        attr_reader :address_mapper, :role_mapper
    end
  end
end
