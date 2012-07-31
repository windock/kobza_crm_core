require 'kobza_crm/domain/party_role'

module KobzaCRM module Domain
  class CustomerRole < PartyRole
    attr_accessor :customer_value

    def initialize
      @name = 'customer'
    end

    def ==(o)
      id == o.id &&
      party == o.party &&
      customer_value == o.customer_value
    end
  end
end end
