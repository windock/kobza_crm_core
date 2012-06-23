require 'kobza_crm/party_role'

module KobzaCRM
  class CustomerRole < PartyRole
    attr_accessor :customer_value

    def initialize
      @name = 'customer'
    end
  end
end
