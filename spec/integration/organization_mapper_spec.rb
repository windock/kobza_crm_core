require 'mongobzar'
require 'kobza_crm/persistence/organization_mapper'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Test
      describe OrganizationMapper do
        subject { repository }
        let(:repository) {
          OrganizationMapper.new(database_name)
        }

        let(:collection_name) { 'organizations' }

        let(:party) { Organization.new(sample_name) }
        let(:other_party) { Organization.new('Bobka') }

        it_behaves_like 'a mongo party repository'
      end
    end
  end
end
