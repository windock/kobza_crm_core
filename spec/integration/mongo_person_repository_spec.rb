require 'mongobzar'
require 'kobza_crm/persistence/mongo_person_repository'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Tests
      describe MongoPersonRepository do
        subject { repository }
        let(:repository) { MongoPersonRepository.instance(id_generator, database_name) }

        let(:collection_name) { 'people' }

        let(:party) { Person.new(sample_name) }
        let(:other_party) { Person.new('bill') }

        it_behaves_like 'a mongo party repository'
      end
    end
  end
end
