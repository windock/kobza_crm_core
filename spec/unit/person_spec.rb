require 'kobza_crm/domain/person'
require_relative 'shared_examples_for_party'

module KobzaCRM
  module Test
    describe Domain::Person do
      subject { Domain::Person.new(sample_name) }

      let(:sample_name) { 'Bob' }

      it 'may be created, given name' do
        Domain::Person.new(sample_name).name.should == sample_name
      end

      it_behaves_like 'a party'

      describe '==' do
        it 'is true if all attributes are equal' do
          p1 = Domain::Person.new('name1')
          p1.id = 1

          p2 = Domain::Person.new('name1')
          p2.id = 1

          p1.should == p2
        end

        it 'is false if any attribute is not equal' do
          p1 = Domain::Person.new('name1')
          p1.id = 1

          p2 = Domain::Person.new('name2')
          p2.id = 2

          p1.should_not == p2
        end
      end
    end
  end
end
