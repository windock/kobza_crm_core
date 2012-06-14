require 'kobza_crm'

module KobzaCRM
  module Test
    describe AddEmailAddressTransaction do
      before do
        id_generator = Mongobzar::BSONIdGenerator.new
        @person_repository = InMemoryPersonRepository.new(id_generator)
        t = AddPersonTransaction.new('Bob', @person_repository)
        t.execute
        @person = t.person
      end

      it 'adds EmailAddress to Person' do
        t = AddEmailAddressTransaction.new(@person.id, 'test1@example.com', @person_repository)
        t.execute

        @person.addresses.first.email_address.should == 'test1@example.com'
      end
    end
  end
end
