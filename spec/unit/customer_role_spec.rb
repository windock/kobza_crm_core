require 'kobza_crm/domain/customer_role'
require_relative 'shared_examples_for_party_role'

module KobzaCRM
  describe Domain::CustomerRole do
    it_behaves_like 'party role'

    it 'has a "customer" name' do
      subject.name.should == 'customer'
    end

    it 'may have customer_value associated' do
      subject.customer_value = 3
      subject.customer_value.should == 3
    end
  end
end

