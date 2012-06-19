require 'kobza_crm/customer_role'

module KobzaCRM
  module Persistence
    class RoleMapper < Mongobzar::Mapping::EmbeddedMapper
      def build_dto!(dto, role)
        dto['name'] = 'role'
        dto['customer_value'] = role.customer_value
      end

      def build_new(dto)
        role = CustomerRole.new
        role.customer_value = dto['customer_value']
        role
      end
    end
  end
end
