require 'kobza_crm/customer_role'
require 'kobza_crm/customer_service_representative_role'

module KobzaCRM
  module Persistence
    class RoleMapper < Mongobzar::Mapping::DependentMapper
      def initialize(*args)
        super
        self.foreign_key = 'party_id'
      end

      def mongo_collection_name
        'party_roles'
      end

      def build_dto!(dto, role)
        if role.kind_of?(CustomerServiceRepresentativeRole)
          dto['type'] = 'customer_service_representative'
        elsif role.kind_of?(CustomerRole)
          #FIXME: what?
          dto['type'] = 'customer'
          dto['customer_value'] = role.customer_value
        end
      end

      def build_new(dto)
        if dto['type'] == 'customer_service_representative'
          CustomerServiceRepresentativeRole.new
        elsif dto['type'] == 'customer'
          role = CustomerRole.new
          role.customer_value = dto['customer_value']
          role
        end
      end
    end
  end
end
