require 'kobza_crm/domain/customer_service_representative_role'
require 'kobza_crm/service/make_person_role_transaction'

module KobzaCRM
  module Service
    class MakePersonACustomerServiceRepresentativeTransaction < MakePersonRoleTransaction
      def build_role
        Domain::CustomerServiceRepresentativeRole.new
      end
    end
  end
end
