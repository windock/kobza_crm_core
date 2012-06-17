require 'kobza_crm/email_address'

module KobzaCRM
  class AddEmailAddressTransaction
    def initialize(person_id, email_address, person_repository)
      @person_repository = person_repository

      @person_id = person_id
      @email_address = email_address
    end

    def execute
      person = @person_repository.find(@person_id)
      person.add_address(EmailAddress.new(@email_address))

      @person_repository.update(person)
    end
  end
end
