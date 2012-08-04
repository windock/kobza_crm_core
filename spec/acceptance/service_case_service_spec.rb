require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  describe ServiceCaseService do
    let(:sample_name) { 'Bob' }
    let(:repository_factory) do
      Infrastructure::Persistence::Memory::RepositoryFactory.new
    end
    let(:service_case_repository) do
      repository_factory.service_case_repository
    end
    let(:service) { ServiceCaseService.new(service_case_repository) }

    let(:party_repository) { repository_factory.party_repository }
    let(:role_repository) { repository_factory.role_repository }
    let(:party_service) do
      Service::PartyService.new(party_repository, role_repository)
    end

    before do
      @party = party_service.add_person(sample_name)
      party_service.make_customer(@party.id, 3)
    end

    let(:title) { 'Sample title' }
    let(:brief_description) { 'Sample description' }
    let(:raised_by) { party }
    let(:party) { @party }

    # As a CustomerServiceRepresentative
    # I want to start CommunicationThread for ServiceCase
    # so that I may group Communications with Client
    # by topic
    describe '#start_communication_thread' do
      context 'given there is a ServiceCase opened' do
        let(:service_case) { service_case_repository.all.first }
        let(:ct_brief_description) do
          'Sample CT description'
        end
        let(:topic_name) { 'Sample topic' }

        before do
          service.open_service_case(title, brief_description, raised_by)
        end

        describe 'adds CommunicationThread to Service Case
            and persists it' do

          before do
            service.start_communication_thread(
              service_case.id, topic_name,
              ct_brief_description)
          end

          subject { service_case.communication_threads.first }

          its(:brief_description) { should == ct_brief_description }
        end
      end
    end

    # As a CustomerServiceRepresentative
    # I want to open ServiceCase
    # so that I may organize Communications with Client
    describe '#open_service_case' do
      describe 'adds ServiceCase to ServiceCaseRepository' do
        before do
          service.open_service_case(title, brief_description, raised_by)
        end

        subject { service_case_repository.all.first }
        its(:title) { should == title }
        its(:brief_description) { should == brief_description }
        its(:raised_by) { should == raised_by }
      end
    end
  end
end end end
