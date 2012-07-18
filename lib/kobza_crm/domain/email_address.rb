module KobzaCRM module Domain
  class EmailAddress
    def initialize(email_address)
      @email_address = email_address
    end

    attr_reader :email_address
  end
end end
