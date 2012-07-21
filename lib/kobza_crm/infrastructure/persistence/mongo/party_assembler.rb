require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class PartyAssembler < Mongobzar::Assembler::Assembler
    def initialize(address_assembler, role_assembler)
      @address_assembler = address_assembler
      @role_assembler = role_assembler
    end

    def build_domain_object!(party, dto)
      address_assembler.build_domain_objects(dto['addresses']).each do |address|
        party.add_address(address)
      end

      role_assembler.find_dependent_collection(party).each do|role|
        party.add_role(role)
      end
    end

    def build_dto!(dto, party)
      dto['name'] = party.name

      dto['addresses'] = address_assembler.build_dtos(
        party.addresses
      )
    end

    private
      attr_reader :address_assembler
      attr_reader :role_assembler

  end
end end end end
