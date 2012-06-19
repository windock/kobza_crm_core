require 'mongobzar'
require 'kobza_crm/persistence/address_mapper'
require 'kobza_crm/persistence/role_mapper'

module KobzaCRM
  module Persistence
    class PartyMapper < Mongobzar::Mapping::Mapper
      def initialize(database_name)
        super
        @address_mapper = AddressMapper.new
        @role_mapper = RoleMapper.new
      end

      def build_dto!(dto, party)
        dto['name'] = party.name

        dto['roles'] = @role_mapper.build_embedded_collection(
          party.roles
        )

        dto['addresses'] = @address_mapper.build_embedded_collection(
          party.addresses
        )
      end

      def build_domain_object!(party, dto)
        @address_mapper.build_domain_objects(dto['addresses']).each do |address|
          party.add_address(address)
        end

        @role_mapper.build_domain_objects(dto['roles']).each do |role|
          party.add_role(role)
        end
      end
    end
  end
end
