require 'kobza_crm/no_public_new'
require 'kobza_crm/customer_role'
require 'kobza_crm/persistence/inheritance_mapper'

module KobzaCRM
  module Persistence
    class CustomerRoleMapper < InheritanceMapper
      include NoPublicNew

      def self.instance
        new(CustomerRole, 'customer')
      end

      def build_domain_object!(role, dto)
        role.customer_value = dto['customer_value']
      end

      def build_dto!(dto, role)
        super
        dto['customer_value'] = role.customer_value
      end
    end
  end
end
