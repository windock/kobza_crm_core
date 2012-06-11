module KobzaCRM
  class Organization
    def initialize(name)
      @name = name
    end

    attr_reader :name
    attr_accessor :id
  end
end
