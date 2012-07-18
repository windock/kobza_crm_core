require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    # As a user,
    # I want to make some person a customer,
    # so that I may treat it like one
    describe MakePersonACustomerTransaction do
      let(:person_repository) do
        InMemoryPersonRepository.instance
      end

      before do
        t = AddPersonTransaction.new('Bob', person_repository)
        t.execute

        @person = t.person

        t = MakePersonACustomerTransaction.new(
          @person.id, person_repository)
        t.customer_value = 3
        t.execute

        @found_person = person_repository.find(@person.id)
        @role = @found_person.roles.first
      end

      it 'adds Customer role to the Person' do
        @found_person.roles.size.should == 1

        @role.should be_kind_of(Domain::CustomerRole)
        @role.customer_value.should == 3
      end

      it 'sets id for the Customer role' do
        @role.id.should_not be_nil
      end
    end
  end
end
