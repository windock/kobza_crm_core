module KobzaCRM
  class Party
    attr_accessor :name
    attr_accessor :id
    attr_reader :addresses
    attr_reader :roles

    def initialize(name)
      @name = name
      @addresses = []
      @roles = []
    end

    def add_address(address)
      @addresses << address
    end

    def add_role(role)
      @roles << role
    end

    def ==(o)
      id == o.id &&
      name == o.name &&
      addresses == o.addresses
    end

    def initialize_copy(o)
      @addresses = []
      o.addresses.each do |address|
        add_address(address.dup)
      end
    end
  end
end
