require 'kobza_crm/customer_service_representative_role'

module KobzaCRM
  describe CustomerServiceRepresentativeRole do
    it 'has a "customer_service_representative" name' do
      subject.name.should == 'customer_service_representative'
    end

    it 'may have a party associated' do
      party = stub
      subject.party = party
      subject.party.should == party
    end
  end
end
