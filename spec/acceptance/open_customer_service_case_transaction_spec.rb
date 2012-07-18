require 'kobza_crm'
require 'kobza_crm/persistence/memory/party_repository'
require 'mongobzar'

module KobzaCRM module Service module Test
  # As a CustomerServiceRepresentative
  # I want to open CustomerServiceCase
  # so that I may organize Communications with him
  describe OpenCustomerServiceCaseTransaction do
    let(:customer_service_case_repository) do
      Persistence::Memory::PartyRepository.instance
    end

    before do
      person_repository = Persistence::Memory::PartyRepository.instance
      t = AddPersonTransaction.new('Bob', person_repository)
      t.execute
      @person = t.person

      MakePersonACustomerTransaction.new(@person.id, person_repository).execute
    end

    let(:title) { 'Sample title' }
    let(:brief_description) { 'Sample description' }
    let(:raised_by) { @person }

    it 'adds CustomerServiceCase to Repository' do
      pending
      t = OpenCustomerServiceCaseTransaction.new(
        title, brief_description, raised_by,
        customer_service_case_repository)
      t.execute

      csc = customer_service_case_repository.all.first
      csc.title.should == title
      csc.brief_description.should == brief_description
      csc.raised_by.should == raised_by
    end
  end
end end end
