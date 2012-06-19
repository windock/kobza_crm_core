module KobzaCRM
  class Repository
    def self.instance(*args)
      new(*args)
    end
    private_class_method :new
  end
end
