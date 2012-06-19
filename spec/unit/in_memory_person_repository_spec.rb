require 'kobza_crm/in_memory_person_repository'
require 'kobza_crm/person'
require_relative 'shared_examples_for_in_memory_party_repository'

module KobzaCRM
  module Test
    describe InMemoryPersonRepository do
      subject { InMemoryPersonRepository.instance(id_generator) }

      it_behaves_like 'an in memory party repository'

      let(:party) { Person.new('bob') }
      let(:other_party) { Person.new('bill') }
    end
  end
end
