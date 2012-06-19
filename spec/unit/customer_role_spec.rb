require 'kobza_crm/customer_role'

module KobzaCRM
  describe CustomerRole do
    it 'has a "customer" name' do
      subject.name.should == 'customer'
    end

    it 'may be have party associated' do
      party = stub
      subject.party = party
      subject.party.should == party
    end

    it 'may have customer_value associated' do
      subject.customer_value = 3
      subject.customer_value.should == 3
    end
  end
end

