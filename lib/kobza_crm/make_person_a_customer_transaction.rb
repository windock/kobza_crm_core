require 'kobza_crm/customer_role'

module KobzaCRM
  class MakePersonACustomerTransaction
    def initialize(person_id, person_repository)
      @person_repository = person_repository

      @person_id = person_id
    end

    attr_accessor :customer_value

    def execute
      person = @person_repository.find(@person_id)

      role = CustomerRole.new(person)
      role.customer_value = customer_value

      person.add_role(role)

      @person_repository.update(person)
    end
  end
end
