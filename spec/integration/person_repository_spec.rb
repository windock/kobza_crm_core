require 'kobza_crm/persistence/person_mapper'
require 'kobza_crm/persistence/party_repository'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Test
      describe PartyRepository do
        let(:mapper_class) { PersonMapper }

        let(:collection_name) { 'people' }

        let(:party) { Person.new(sample_name) }
        let(:other_party) { Person.new('bill') }

        it_behaves_like 'a mongo party repository'
      end
    end
  end
end
