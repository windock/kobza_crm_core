require 'kobza_crm/person'

module KobzaCRM
  module Test
    describe Person do
      subject { Person.new(sample_name) }

      let(:sample_name) { 'Bob' }

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

      describe '==' do
        it 'is true if all attributes are equal' do
          p1 = Person.new('name1')
          p1.id = 1

          p2 = Person.new('name1')
          p2.id = 1

          p1.should == p2
        end

        it 'is not true if any attribute is not equal' do
          p1 = Person.new('name1')
          p1.id = 1

          p2 = Person.new('name2')
          p2.id = 2

          p1.should_not == p2
        end
      end
    end
  end
end
