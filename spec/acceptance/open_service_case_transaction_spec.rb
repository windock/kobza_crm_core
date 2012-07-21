require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  # As a CustomerServiceRepresentative
  # I want to open ServiceCase
  # so that I may organize Communications with him
  describe OpenServiceCaseTransaction do
    let(:service_case_repository) do
      #FIXME:
      Infrastructure::Persistence::Memory::RepositoryFactory.new.party_repository
    end

    before do
      person_repository = Infrastructure::Persistence::Memory::RepositoryFactory.new.party_repository
      t = AddPersonTransaction.new('Bob', person_repository)
      t.execute
      @person = t.person

      MakePersonACustomerTransaction.new(@person.id, person_repository).execute
    end

    let(:title) { 'Sample title' }
    let(:brief_description) { 'Sample description' }
    let(:raised_by) { @person }

    it 'adds ServiceCase to Repository' do
      t = OpenServiceCaseTransaction.new(
        title, brief_description, raised_by,
        service_case_repository)
      t.execute

      csc = service_case_repository.all.first
      csc.title.should == title
      csc.brief_description.should == brief_description
      csc.raised_by.should == raised_by
    end
  end
end end end
