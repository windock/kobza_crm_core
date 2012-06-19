module KobzaCRM
  class CustomerRole
    attr_accessor :customer_value
    attr_reader :party

    def initialize(party)
      @party = party
    end
  end
end
