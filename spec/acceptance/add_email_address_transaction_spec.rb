require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  # As a user,
  # I want to add email address to the party,
  # so that I may contact it later by email
  describe AddEmailAddressTransaction do
    let(:person_repository) { Infrastructure::Persistence::Memory::PartyRepository.new }

    before do
      t = AddPersonTransaction.new('Bob', person_repository)
      t.execute
      @person_id = t.person.id

      t = AddEmailAddressTransaction.new(@person_id, sample_email, person_repository)
      t.execute
    end

    let(:sample_email) { 'test1@example.com' }

    it 'adds EmailAddress to Person' do
      addresses = person_repository.find(@person_id).addresses
      email_address = addresses.first

      email_address.should be_kind_of(Domain::EmailAddress)
      email_address.email_address.should == sample_email
    end
  end
end end end
