require 'mongobzar'
require 'kobza_crm/persistence/address_mapper'
require 'kobza_crm/persistence/role_mapper'

module KobzaCRM
  module Persistence
    class PartyMapper < Mongobzar::Mapping::Mapper
      def initialize(database_name)
        super
        @address_mapper = AddressMapper.new
        @role_mapper = RoleMapper.new(database_name)
      end

      def build_dto!(dto, party)
        dto['name'] = party.name

        dto['addresses'] = @address_mapper.build_embedded_collection(
          party.addresses
        )
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
        @address_mapper.build_domain_objects(dto['addresses']).each do |address|
          party.add_address(address)
        end

        @role_mapper.find_dependent_collection(party).each do|role|
          party.add_role(role)
        end
      end

      def clear_everything!
        super
        @role_mapper.clear_everything!
      end
    end
  end
end
