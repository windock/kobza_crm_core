require 'kobza_crm/customer_role'
require 'kobza_crm/customer_service_representative_role'
require 'kobza_crm/persistence/inheritance_mapping_strategy'
require 'kobza_crm/persistence/polymorphic_mapping_strategy'

module KobzaCRM
  module Persistence
    class RoleMapper < Mongobzar::Mapping::DependentMapper
      include NoPublicNew

      def initialize(*args)
        super
        self.foreign_key = 'party_id'
        @mapping_strategy = PolymorphicMappingStrategy.new([
          CustomerRoleMapper.new,
          CustomerServiceRepresentativeRoleMapper.new
        ])
      end

      def mongo_collection_name
        'party_roles'
      end

      def build_new(dto)
        @mapping_strategy.build_new(dto)
      end

      def build_domain_object!(role, dto)
        @mapping_strategy.build_domain_object!(role, dto)
      end

      def build_dto!(dto, role)
        @mapping_strategy.build_dto!(dto, role)
      end
    end

    class CustomerServiceRepresentativeRoleMapper < InheritanceMappingStrategy
      def type_code
        'customer_service_representative'
      end

      def domain_object_class
        CustomerServiceRepresentativeRole
      end
    end

    class CustomerRoleMapper < InheritanceMappingStrategy
      def build_domain_object!(role, dto)
        role.customer_value = dto['customer_value']
      end

      def build_dto!(dto, role)
        super
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
