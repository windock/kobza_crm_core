require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class PartyAssembler < Mongobzar::Assembler::Assembler
    def initialize(address_source)
      @address_source = address_source
    end

    attr_writer :role_source

    def build_domain_object!(party, dto)
      address_source.build_domain_objects(dto['addresses']).each do |address|
        party.add_address(address)
      end

      role_source.find_for_party(party).each do|role|
        party.add_role(role)
      end
    end

    def build_dto!(dto, party)
      dto['name'] = party.name

      dto['addresses'] = address_source.build_dtos(
        party.addresses
      )
    end

    private
      attr_reader :address_source
      attr_reader :role_source

  end
end end end end
