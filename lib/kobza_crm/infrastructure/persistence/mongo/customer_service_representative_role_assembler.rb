require 'kobza_crm/domain/customer_service_representative_role'
require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class CustomerServiceRepresentativeRoleAssembler
    def initialize(party_source)
      @party_source = party_source
    end

    def build_new(dto)
      Domain::CustomerServiceRepresentativeRole.new
    end

    def build_domain_object!(role, dto)
      role.party = Mongobzar::Utility::VirtualProxy.new -> do
        party_source.find(dto['party_id'])
      end
    end

    def build_dto!(dto, role)
      dto['party_id'] = role.party.id
    end

    private
      attr_reader :party_source
  end
end end end end
