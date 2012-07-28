require 'kobza_crm/domain/customer_service_representative_role'
require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class DependentCustomerServiceRepresentativeRoleAssembler < Mongobzar::Assembler::Assembler
    def build_new(dto)
      Domain::CustomerServiceRepresentativeRole.new
    end
  end
end end end end
