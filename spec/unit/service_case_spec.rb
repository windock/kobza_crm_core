require 'kobza_crm/domain/service_case'
require_relative 'shared_examples_for_has_identity'

module KobzaCRM module Domain module Test
  describe ServiceCase do
    it_behaves_like 'has identity'

    let(:title) { 'Sample title' }
    let(:brief_description) { 'Short description' }
    let(:raised_by) { stub }

    def new_service_case
      ServiceCase.new(
        title, brief_description, raised_by)
    end
    let(:service_case) { new_service_case }

    subject do
      new_service_case
    end

    describe 'starts communication thread' do
      let(:topic_name) { 'Topic1' }
      let(:brief_description) { 'Desc1' }

      before do
        service_case.start_communication_thread(topic_name,
                                                brief_description)
      end

      subject { service_case.communication_threads.first }

      its(:brief_description) { should == brief_description }
      its(:topic_name) { should == topic_name }
    end

    describe 'communication threads may be added' do
      let(:threads) { [stub, stub] }
      before do
        service_case.add_communication_thread(threads[0])
        service_case.add_communication_thread(threads[1])
      end

      subject { service_case }
      its(:communication_threads) { should have(2).items }
    end

    it 'allows change of title' do
      subject.title = 'other title'
      subject.title.should == 'other title'
    end

    it 'may be created, given title, brief_description and raised_by' do
      subject.title.should == title
      subject.brief_description.should == brief_description
      subject.raised_by.should == raised_by
    end

    describe '==' do
      it 'is true if all attributes are equal' do
        c1 = new_service_case
        c1.id = 1
        c2 = new_service_case
        c2.id = 1

        c1.should == c2
      end

      it 'is false if any attribute is not equal' do
        c1 = new_service_case
        c1.id = 1
        c2 = ServiceCase.new(
          'title2', brief_description, raised_by)
        c2.id = 2

        c1.should_not == c2
      end
    end
  end
end end end
