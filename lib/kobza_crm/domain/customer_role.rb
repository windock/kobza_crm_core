require 'kobza_crm/domain/party_role'

module KobzaCRM
  class CustomerRole < PartyRole
    attr_accessor :customer_value

    def initialize
      @name = 'customer'
    end
  end
end
