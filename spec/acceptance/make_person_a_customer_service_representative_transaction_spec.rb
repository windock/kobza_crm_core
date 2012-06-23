require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    # As a user,
    # I want to make some person a customer service representative,
    # so that I may treat it like one
    describe MakePersonACustomerServiceRepresentativeTransaction do
      let(:person_repository) do
        InMemoryPersonRepository.instance(Mongobzar::BSONIdGenerator.new)
      end

      before do
        t = AddPersonTransaction.new('Bob', person_repository)
        t.execute

        @person = t.person
      end

      it 'adds CustomerServiceRepresentative to the Person' do
        t = MakePersonACustomerServiceRepresentativeTransaction.new(
          @person.id, person_repository)
        t.execute

        found_person = person_repository.find(@person.id)
        found_person.roles.size.should == 1
        role = found_person.roles.first

        role.should be_kind_of(CustomerServiceRepresentativeRole)
      end
    end
  end
end
