require 'kobza_crm/person'

module KobzaCRM
  module Test
    describe Person do
      let(:sample_name) { 'Bob' }
      let(:subject) { Person.new(sample_name) }

      it 'may be created, given name' do
        Person.new(sample_name).name.should == sample_name
      end

      context 'addresses' do
        it 'may have multiple addresses' do
          address1 = stub
          address2 = stub

          subject.add_address(address1)
          subject.add_address(address2)

          subject.addresses.should == [address1, address2]
        end
      end
    end
  end
end
