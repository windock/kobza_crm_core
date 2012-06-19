module KobzaCRM
  class CustomerRole
    attr_accessor :customer_value
    attr_accessor :party
    attr_reader :name

    def initialize
      @name = 'customer'
    end
  end
end
