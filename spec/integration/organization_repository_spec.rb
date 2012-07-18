require 'kobza_crm/persistence/mongo/organization_mapper'
require 'kobza_crm/persistence/mongo/party_repository'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM module Persistence module Mongo module Test
  describe PartyRepository do
    let(:mapper_class) { OrganizationMapper }

    let(:collection_name) { 'organizations' }

    let(:party) { Domain::Organization.new(sample_name) }
    let(:other_party) { Domain::Organization.new('Bobka') }

    it_behaves_like 'a mongo party repository'
  end
end end end end
