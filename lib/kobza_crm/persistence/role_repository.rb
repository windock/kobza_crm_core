require 'kobza_crm/no_public_new'
require 'kobza_crm/customer_role'
require 'kobza_crm/customer_service_representative_role'

module KobzaCRM
  module Persistence
    class RoleRepository < Mongobzar::Repository::DependentRepository
      include NoPublicNew

      def mapping_strategy
        Mongobzar::MappingStrategy::PolymorphicMappingStrategy.new([
          CustomerRoleMappingStrategy.instance,
          CustomerServiceRepresentativeRoleMappingStrategy.instance
        ])
      end

      def foreign_key
        'party_id'
      end

      def mongo_collection_name
        'party_roles'
      end
    end

    class CustomerServiceRepresentativeRoleMappingStrategy < Mongobzar::MappingStrategy::EntityMappingStrategy
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

    class CustomerRoleMappingStrategy < Mongobzar::MappingStrategy::EntityMappingStrategy
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
