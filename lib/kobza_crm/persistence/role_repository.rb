require 'kobza_crm/no_public_new'
require 'kobza_crm/customer_role'
require 'kobza_crm/customer_service_representative_role'

module KobzaCRM
  module Persistence
    class RoleRepository < Mongobzar::Repository::DependentRepository
      include NoPublicNew

      attr_accessor :foreign_key
    end

    class CustomerServiceRepresentativeRoleMapper < Mongobzar::Mapper::EntityMapper
      include NoPublicNew

      def type_code
        'customer_service_representative'
      end

      def build_new(dto)
        domain_object_class.new
      end

      def build_dto!(dto, role)
        dto['type'] = type_code
      end

      def domain_object_class
        CustomerServiceRepresentativeRole
      end
    end

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
