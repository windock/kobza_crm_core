require 'kobza_crm/customer_service_representative_role'

module KobzaCRM
  module Persistence
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

  end
end
