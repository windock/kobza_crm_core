require 'mongobzar'
require 'kobza_crm/persistence/mongo_organization_repository'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Test
      describe MongoOrganizationRepository do
        subject { repository }
        let(:repository) { MongoOrganizationRepository.instance(database_name) }

        let(:collection_name) { 'organizations' }

        let(:party) { Organization.new(sample_name) }
        let(:other_party) { Organization.new('Bobka') }

        it_behaves_like 'a mongo party repository'
      end
    end
  end
end
