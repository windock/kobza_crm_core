module KobzaCRM
  class Organization
    def initialize(name)
      @name = name
      @addresses = []
    end

    attr_reader :name
    attr_accessor :id
    attr_reader :addresses

    def add_address(address)
      @addresses << address
    end

    def ==(o)
      id == o.id &&
      name == o.name &&
      addresses == o.addresses
    end
  end
end
