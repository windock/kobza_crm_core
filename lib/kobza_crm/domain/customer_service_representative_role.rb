require 'kobza_crm/domain/party_role'

module KobzaCRM module Domain
  class CustomerServiceRepresentativeRole < PartyRole
    def initialize
      @name = 'customer_service_representative'
    end

    def ==(o)
      id == o.id &&
      party == o.party
    end
  end
end end
