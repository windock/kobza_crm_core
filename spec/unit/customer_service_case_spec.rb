require 'kobza_crm/domain/customer_service_case'
require_relative 'shared_examples_for_has_identity'

module KobzaCRM
  module Test
    describe Domain::CustomerServiceCase do
      it_behaves_like 'has identity'

      let(:title) { 'Sample title' }
      let(:short_description) { 'Short description' }
      let(:raised_by) { stub }

      def new_customer_service_case
        Domain::CustomerServiceCase.new(
          title, short_description, raised_by)
      end

      subject do
        new_customer_service_case
      end

      it 'allows change of title' do
        title = 'other title'
        subject.title = title
        subject.title.should == title
      end

      it 'may be created, given title, short_description and raised_by' do
        subject.title.should == title
        subject.short_description.should == short_description
        subject.raised_by.should == raised_by
      end

      describe '==' do
        it 'is true if all attributes are equal' do
          c1 = new_customer_service_case
          c1.id = 1
          c2 = new_customer_service_case
          c2.id = 1

          c1.should == c2
        end

        it 'is false if any attribute is not equal' do
          c1 = new_customer_service_case
          c1.id = 1
          c2 = Domain::CustomerServiceCase.new(
            'title2', short_description, raised_by)
          c2.id = 2

          c1.should_not == c2
        end
      end
    end
  end
end
