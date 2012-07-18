require 'mongobzar'

module KobzaCRM
  module Persistence
    module Mongo
      class PartyMapper < Mongobzar::Mapper::Mapper
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
    end
  end
end
