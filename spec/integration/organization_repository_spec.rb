require 'mongobzar'
require 'kobza_crm/persistence/organization_mapper'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Test
      describe PartyRepository do
        subject { repository }
        let(:repository) {
          repository = PartyRepository.new(database_name, collection_name)
          repository.mapper = OrganizationMapper.instance(
            AddressMapper.instance,
            RoleRepository.instance(database_name, collection_name)
          )
          repository
        }

        let(:collection_name) { 'organizations' }

        let(:party) { Organization.new(sample_name) }
        let(:other_party) { Organization.new('Bobka') }

        it_behaves_like 'a mongo party repository'
      end
    end
  end
end
