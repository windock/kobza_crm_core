require 'mongobzar'
require 'kobza_crm/persistence/organization_mapper'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Test
      describe PartyRepository do
        subject { repository }
        let(:repository) {
          role_repository = RoleRepository.instance(database_name, 'party_roles')
          role_repository.mapper = Mongobzar::Mapper::PolymorphicMapper.new([
            CustomerRoleMapper.instance,
            CustomerServiceRepresentativeRoleMapper.instance
          ])
          role_repository.foreign_key = 'party_id'

          repository = PartyRepository.new(database_name, collection_name)
          repository.role_repository = role_repository
          repository.mapper = OrganizationMapper.instance(
            AddressMapper.instance,
            role_repository
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
