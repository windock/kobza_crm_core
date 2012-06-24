require 'kobza_crm/customer_role'
require 'kobza_crm/customer_service_representative_role'
require 'kobza_crm/persistence/inheritance_mapper'

module KobzaCRM
  module Persistence
    class CustomerServiceRepresentativeRoleMapper < InheritanceMapper
      def self.type_code
        'customer_service_representative'
      end

      def self.domain_object_class
        CustomerServiceRepresentativeRole
      end
    end

    class CustomerRoleMapper < InheritanceMapper
      def build_domain_object!(role, dto)
        role.customer_value = dto['customer_value']
      end

      def build_dto!(dto, role)
        super
        dto['customer_value'] = role.customer_value
      end

      def self.type_code
        'customer'
      end

      def self.domain_object_class
        CustomerRole
      end
    end

    class RoleMapper < Mongobzar::Mapping::DependentMapper
      def initialize(*args)
        super
        self.foreign_key = 'party_id'
        @c_mapper = CustomerRoleMapper.new
        @csr_mapper = CustomerServiceRepresentativeRoleMapper.new
      end

      def mongo_collection_name
        'party_roles'
      end

      def build_dto!(dto, role)
        mapper_for_domain_object(role).build_dto!(dto, role)
      end

      def build_new(dto)
        mapper_for_dto(dto).build_new(dto)
      end

      def build_domain_object!(role, dto)
        mapper_for_dto(dto).build_domain_object!(role, dto)
      end

      protected
        def mapper_for_domain_object(role)
          case role
          when CustomerRoleMapper.domain_object_class then @c_mapper
          when CustomerServiceRepresentativeRoleMapper.domain_object_class then @csr_mapper
          end
        end

        def mapper_for_dto(dto)
          case dto['type']
          when CustomerRoleMapper.type_code then @c_mapper
          when CustomerServiceRepresentativeRoleMapper.type_code then @csr_mapper
          end
        end
    end
  end
end
