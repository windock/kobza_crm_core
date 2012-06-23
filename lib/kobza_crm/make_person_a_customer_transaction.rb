require 'kobza_crm/customer_role'
require 'kobza_crm/make_person_role_transaction'

module KobzaCRM
  class MakePersonACustomerTransaction < MakePersonRoleTransaction
    attr_accessor :customer_value

    def build_role
      role = CustomerRole.new
      role.customer_value = customer_value
      role
    end
  end
end
