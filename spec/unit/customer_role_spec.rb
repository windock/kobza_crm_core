require 'kobza_crm/domain/customer_role'
require_relative 'shared_examples_for_party_role'

module KobzaCRM module Domain module Test
  describe CustomerRole do
    it_behaves_like 'party role'

    it 'has a "customer" name' do
      subject.name.should == 'customer'
    end

    it 'may have customer_value associated' do
      subject.customer_value = 3
      subject.customer_value.should == 3
    end

    describe '==' do
      let(:party1) { stub }
      let(:id1) { stub }
      let(:customer_value1) { stub }

      let(:role) do
        role = CustomerRole.new
        role.id = id1
        role.party = party1
        role.customer_value = customer_value1
        role
      end

      it 'is true if all attributes are equal' do
        r2 = CustomerRole.new
        r2.id = id1
        r2.party = party1
        r2.customer_value = customer_value1

        role.should == r2
      end

      it 'is false if any attribute differs' do
        r2 = CustomerRole.new
        r2.id = stub
        r2.party = stub
        r2.customer_value = stub

        role.should_not == r2
      end
    end
  end
end end end
