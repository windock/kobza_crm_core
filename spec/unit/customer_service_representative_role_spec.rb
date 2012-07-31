require 'kobza_crm/domain/customer_service_representative_role'
require_relative 'shared_examples_for_party_role'

module KobzaCRM module Domain module Test
  describe CustomerServiceRepresentativeRole do
    it_behaves_like 'party role'

    it 'has a "customer_service_representative" name' do
      subject.name.should == 'customer_service_representative'
    end

    describe '==' do
      let(:party1) { stub }
      let(:id1) { stub }

      let(:role) do
        role = CustomerServiceRepresentativeRole.new
        role.id = id1
        role.party = party1
        role
      end

      it 'is true if all attributes are equal' do
        r2 = CustomerServiceRepresentativeRole.new
        r2.id = id1
        r2.party = party1

        role.should == r2
      end

      it 'is false if any attribute differs' do
        r2 = CustomerServiceRepresentativeRole.new
        r2.id = stub
        r2.party = stub

        role.should_not == r2
      end
    end
  end
end end end
