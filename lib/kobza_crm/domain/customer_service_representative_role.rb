require 'kobza_crm/domain/party_role'

module KobzaCRM module Domain
  class CustomerServiceRepresentativeRole < PartyRole
    def initialize
      @name = 'customer_service_representative'
    end
  end
end end
