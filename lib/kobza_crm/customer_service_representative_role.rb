require 'kobza_crm/party_role'

module KobzaCRM
  class CustomerServiceRepresentativeRole < PartyRole
    def initialize
      @name = 'customer_service_representative'
    end
  end
end
