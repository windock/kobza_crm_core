require 'kobza_crm/domain/customer_service_representative_role'
require 'mongobzar'

module KobzaCRM module Persistence module Mongo
  class CustomerServiceRepresentativeRoleAssembler < Mongobzar::Assembler::Assembler
    def self.instance
      Mongobzar::Assembler::InheritanceAssembler.new(
        Domain::CustomerServiceRepresentativeRole,
        'customer_service_representative',
        Mongobzar::Assembler::EntityAssembler.new(
          new))
    end

    def build_new(dto)
      Domain::CustomerServiceRepresentativeRole.new
    end
  end
end end end
