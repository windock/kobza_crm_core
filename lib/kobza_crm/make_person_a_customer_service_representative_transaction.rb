require 'kobza_crm/customer_service_representative_role'
require 'kobza_crm/make_person_role_transaction'

module KobzaCRM
  class MakePersonACustomerServiceRepresentativeTransaction < MakePersonRoleTransaction
    def build_role
      CustomerServiceRepresentativeRole.new
    end
  end
end
