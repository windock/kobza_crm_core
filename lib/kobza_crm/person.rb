module KobzaCRM
  class Person
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
  end
end
