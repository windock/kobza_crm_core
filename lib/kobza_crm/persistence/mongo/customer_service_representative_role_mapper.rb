require 'kobza_crm/domain/customer_service_representative_role'
require 'mongobzar'

module KobzaCRM module Persistence module Mongo
  class CustomerServiceRepresentativeRoleMapper < Mongobzar::Mapper::Mapper
    def self.instance
      Mongobzar::Mapper::InheritanceMapper.new(
        Domain::CustomerServiceRepresentativeRole,
        'customer_service_representative',
        Mongobzar::Mapper::EntityMapper.new(
          new))
    end

    def build_new(dto)
      Domain::CustomerServiceRepresentativeRole.new
    end
  end
end end end
