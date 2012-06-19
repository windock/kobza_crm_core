require 'kobza_crm/customer_role'

module KobzaCRM
  describe CustomerRole do
    let(:party) { stub }
    subject { CustomerRole.new(party) }

    it 'may be created for party' do
      role = CustomerRole.new(party)
      role.party.should == party
    end

    it 'may have customerlvalue associated' do
      subject.customer_value = 3
      subject.customer_value.should == 3
    end
  end
end

