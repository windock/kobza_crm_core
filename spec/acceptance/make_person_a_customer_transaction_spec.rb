require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    # As a user,
    # I want to make some person a customer,
    # so that I may treat it like one
    describe MakePersonACustomerTransaction do
      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:person_repository) { InMemoryPersonRepository.instance(id_generator) }

      before do
        t = AddPersonTransaction.new('Bob', person_repository)
        t.execute

        @person = t.person
      end

      it 'adds customer role to the person' do
        t = MakePersonACustomerTransaction.new(@person.id, person_repository)
        t.customer_value = 3
        t.execute

        found_person = person_repository.find(@person.id)
        found_person.roles.size.should == 1
        role = found_person.roles.first

        role.should be_kind_of(CustomerRole)
        role.customer_value.should == 3
      end
    end
  end
end
