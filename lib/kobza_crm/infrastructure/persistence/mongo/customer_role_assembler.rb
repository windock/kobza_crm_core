require 'kobza_crm/domain/customer_role'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class CustomerRoleAssembler
    def initialize(party_source)
      @party_source = party_source
    end

    def build_new(dto)
      Domain::CustomerRole.new
    end

    def build_domain_object!(role, dto)
      role.party = Mongobzar::Utility::VirtualProxy.new -> do
        party_source.find(dto['party_id'])
      end
      role.customer_value = dto['customer_value']
    end

    def build_dto!(dto, role)
      dto['party_id'] = role.party.id
      dto['customer_value'] = role.customer_value
    end

    private
      attr_reader :party_source
  end
end end end end
