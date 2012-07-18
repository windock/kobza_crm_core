require 'kobza_crm/domain/customer_service_representative_role'
require_relative 'shared_examples_for_party_role'

module KobzaCRM
  describe Domain::CustomerServiceRepresentativeRole do
    it_behaves_like 'party role'

    it 'has a "customer_service_representative" name' do
      subject.name.should == 'customer_service_representative'
    end
  end
end
