require 'kobza_crm/domain/customer_role'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class DependentCustomerRoleAssembler
    def build_new(dto)
      Domain::CustomerRole.new
    end

    def build_domain_object!(role, dto)
      role.customer_value = dto['customer_value']
    end

    def build_dto!(dto, role)
      dto['customer_value'] = role.customer_value
    end
  end
end end end end
