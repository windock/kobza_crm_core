require 'kobza_crm/no_public_new'
require 'kobza_crm/customer_role'

module KobzaCRM
  module Persistence
    class CustomerRoleMapper < Mongobzar::Mapper::EntityMapper
      include NoPublicNew

      def build_domain_object!(role, dto)
        role.customer_value = dto['customer_value']
      end

      def build_new(dto)
        domain_object_class.new
      end

      def build_dto!(dto, role)
        dto['type'] = type_code
        dto['customer_value'] = role.customer_value
      end

      def type_code
        'customer'
      end

      def domain_object_class
        CustomerRole
      end
    end
  end
end
