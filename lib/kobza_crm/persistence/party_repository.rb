require 'mongobzar'
require 'kobza_crm/persistence/address_mapping_strategy'
require 'kobza_crm/persistence/role_repository'

module KobzaCRM
  module Persistence
    class PartyMappingStrategy < Mongobzar::MappingStrategy::EntityMappingStrategy
      def initialize(address_mapping_strategy, role_mapping_strategy)
        @address_mapping_strategy = address_mapping_strategy
        @role_mapping_strategy = role_mapping_strategy
      end

      def build_domain_object!(party, dto)
        address_mapping_strategy.build_domain_objects(dto['addresses']).each do |address|
          party.add_address(address)
        end

        role_mapping_strategy.find_dependent_collection(party).each do|role|
          party.add_role(role)
        end
      end

      def build_dto!(dto, party)
        dto['name'] = party.name

        dto['addresses'] = address_mapping_strategy.build_dtos(
          party.addresses
        )
      end

      private
        attr_reader :address_mapping_strategy
        attr_reader :role_mapping_strategy

    end

    class PartyRepository < Mongobzar::Repository::Repository
      attr_reader :mapping_strategy

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

      protected
        def role_repository
          RoleRepository.instance(database_name)
        end

        def address_mapping_strategy
          AddressMappingStrategy.instance
        end
    end
  end
end
