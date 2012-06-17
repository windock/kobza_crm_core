require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    describe AddEmailAddressTransaction do
      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:person_repository) { InMemoryPersonRepository.new(id_generator) }

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

        email_address.should be_kind_of(EmailAddress)
        email_address.email_address.should == sample_email
      end
    end
  end
end
