require 'kobza_crm/domain/email_address'

module KobzaCRM module Service
  class AddEmailAddressTransaction
    def initialize(person_id, email_address, person_repository)
      @person_repository = person_repository

      @person_id = person_id
      @email_address = email_address
    end

    def execute
      person = @person_repository.find(@person_id)
      person.add_address(Domain::EmailAddress.new(@email_address))

      @person_repository.update(person)
    end
  end
end end
