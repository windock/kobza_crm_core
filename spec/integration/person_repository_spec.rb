require 'kobza_crm/persistence/mongo/person_assembler'
require 'kobza_crm/persistence/mongo/party_repository'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM module Persistence module Mongo module Test
  describe PartyRepository do
    let(:assembler_class) { PersonAssembler }

    let(:collection_name) { 'people' }

    let(:party) { Domain::Person.new(sample_name) }
    let(:other_party) { Domain::Person.new('bill') }

    it_behaves_like 'a mongo party repository'
  end
end end end end
