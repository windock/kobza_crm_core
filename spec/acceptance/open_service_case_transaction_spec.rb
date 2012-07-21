require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  describe ServiceCaseService do
    let(:sample_name) { 'Bob' }
    let(:service_case_repository) { Infrastructure::Persistence::Memory::RepositoryFactory.new.service_case_repository }
    let(:subject) { ServiceCaseService.new(service_case_repository) }

    let(:party_repository) { Infrastructure::Persistence::Memory::RepositoryFactory.new.party_repository }
    let(:party_service) { Service::PartyService.new(party_repository) }

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
