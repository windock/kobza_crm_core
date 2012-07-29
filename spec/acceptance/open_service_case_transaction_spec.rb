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
    let(:subject) { ServiceCaseService.new(service_case_repository) }

    let(:party_repository) { repository_factory.party_repository }
    let(:role_repository) { repository_factory.role_repository }
    let(:party_service) do
      Service::PartyService.new(party_repository, role_repository)
    end

    # As a CustomerServiceRepresentative
    # I want to open ServiceCase
    # so that I may organize Communications with him
    describe 'open' do
      let(:title) { 'Sample title' }
      let(:brief_description) { 'Sample description' }
      let(:raised_by) { party }
      let(:party) { @party }

      before do
        @party = party_service.add_person(sample_name)
        party_service.make_customer(@party.id, 3)
      end

      it 'adds ServiceCase to ServiceCaseRepository' do
        subject.open(title, brief_description, raised_by)
        sc = service_case_repository.all.first
        sc.title.should == title
        sc.brief_description.should == brief_description
        sc.raised_by.should == raised_by
      end
    end
  end
end end end
