require 'kobza_crm/no_public_new'
require 'kobza_crm/customer_role'
require 'kobza_crm/customer_service_representative_role'
require 'kobza_crm/persistence/polymorphic_mapping_strategy'

module KobzaCRM
  module Persistence
    class RoleMapper < Mongobzar::Mapping::DependentMapper
      include NoPublicNew

      def initialize(*args)
        super
        self.foreign_key = 'party_id'
        @mapping_strategy = PolymorphicMappingStrategy.new([
          CustomerRoleMappingStrategy.instance,
          CustomerServiceRepresentativeRoleMappingStrategy.instance
        ])
      end

      attr_reader :mapping_strategy

      def mongo_collection_name
        'party_roles'
      end
    end

    class CustomerServiceRepresentativeRoleMappingStrategy < Mongobzar::Mapping::WithIdentityMappingStrategy
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

    class CustomerRoleMappingStrategy < Mongobzar::Mapping::WithIdentityMappingStrategy
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
