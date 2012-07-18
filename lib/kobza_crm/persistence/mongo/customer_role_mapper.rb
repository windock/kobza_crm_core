require 'kobza_crm/domain/customer_role'
require 'mongobzar/mapper/inheritance_mapper'

module KobzaCRM module Persistence module Mongo
  class CustomerRoleMapper
    def self.instance
      Mongobzar::Mapper::InheritanceMapper.new(
        Domain::CustomerRole, 'customer',
        Mongobzar::Mapper::EntityMapper.new(new))
    end

    def build_new(dto)
      Domain::CustomerRole.new
    end

    def build_domain_object!(role, dto)
      role.customer_value = dto['customer_value']
    end

    def build_dto!(dto, role)
      dto['customer_value'] = role.customer_value
    end
  end
end end end
