require 'kobza_crm/organization'
require_relative 'shared_examples_for_party'

module KobzaCRM
  module Test
    describe Organization do
      subject { Organization.new(sample_name) }

      let(:sample_name) { 'Orga' }

      it 'may be created, given name' do
        Organization.new(sample_name).name.should == sample_name
      end

      it_behaves_like 'a party'

      describe '==' do
        it 'is true if all attributes are equal' do
          o1 = Organization.new('name1')
          o1.id = 1

          o2 = Organization.new('name1')
          o2.id = 1

          o1.should == o2
        end

        it 'is not true if any attribute is not equal' do
          o1 = Organization.new('name1')
          o1.id = 1

          o2 = Organization.new('name2')
          o2.id = 2

          o1.should_not == o2
        end
      end
    end
  end
end
