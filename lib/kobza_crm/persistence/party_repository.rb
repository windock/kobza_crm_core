require 'mongobzar'
require 'kobza_crm/persistence/address_mapper'
require 'kobza_crm/persistence/customer_role_mapper'
require 'kobza_crm/persistence/customer_service_representative_role_mapper'

module KobzaCRM
  module Persistence
    class PartyMapper < Mongobzar::Mapper::EntityMapper
      def initialize(address_mapper, role_mapper)
        @address_mapper = address_mapper
        @role_mapper = role_mapper
      end

      def build_domain_object!(party, dto)
        address_mapper.build_domain_objects(dto['addresses']).each do |address|
          party.add_address(address)
        end

        role_mapper.find_dependent_collection(party).each do|role|
          party.add_role(role)
        end
      end

      def build_dto!(dto, party)
        dto['name'] = party.name

        dto['addresses'] = address_mapper.build_dtos(
          party.addresses
        )
      end

      private
        attr_reader :address_mapper
        attr_reader :role_mapper

    end

    class PartyRepository < Mongobzar::Repository::Repository
      def insert(party)
        super
        role_repository.insert_dependent_collection(party, party.roles)
      end

      def update(party)
        super
        role_repository.update_dependent_collection(party, party.roles)
      end

      def clear_everything!
        super
        role_repository.clear_everything!
      end

      attr_accessor :role_repository
    end
  end
end
