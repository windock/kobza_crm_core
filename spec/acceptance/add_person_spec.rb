require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    # As a user,
    # I want to add a person,
    # so that I may keep track of it
    describe AddPersonTransaction do
      let(:person_repository) do
        InMemoryPersonRepository.instance(Mongobzar::BSONIdGenerator.new)
      end
      let(:sample_name) { 'Bob' }

      it 'adds Person to PersonRepository' do
        t = AddPersonTransaction.new(sample_name, person_repository)
        t.execute

        person = person_repository.all.first
        person.name.should == sample_name
      end

      it 'provides person with set id after execution' do
        t = AddPersonTransaction.new(sample_name, person_repository)

        t.execute
        person = t.person

        person.id.should_not be_nil
        person.name.should == sample_name
      end
    end
  end
end
