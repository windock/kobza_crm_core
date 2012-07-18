require 'kobza_crm/in_memory_person_repository'
require 'kobza_crm/domain/person'
require_relative 'shared_examples_for_in_memory_party_repository'

module KobzaCRM
  module Test
    describe InMemoryPersonRepository do
      subject { InMemoryPersonRepository.instance }

      include_context 'an in memory repository context'
      it_behaves_like 'an in memory party repository'

      let(:party) { Domain::Person.new('bob') }
      let(:other_party) { Domain::Person.new('bill') }

    end
  end
end
