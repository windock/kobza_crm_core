require 'mongobzar'
require 'kobza_crm/persistence/organization_mapper'
require 'kobza_crm/persistence/customer_role_mapper'
require 'kobza_crm/persistence/email_address_mapper'
require 'kobza_crm/persistence/web_page_address_mapper'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Test
      describe PartyRepository do
        subject { repository }
        let(:repository) {
          role_repository = Mongobzar::Repository::DependentRepository.new(database_name, 'party_roles')
          role_repository.mapper = Mongobzar::Mapper::PolymorphicMapper.new([
            CustomerRoleMapper.instance,
            InheritanceMapper.new(CustomerServiceRepresentativeRole,
                                  'customer_service_representative')
          ])
          role_repository.foreign_key = 'party_id'

          repository = PartyRepository.new(database_name, collection_name)
          repository.role_repository = role_repository
          address_mapper = Mongobzar::Mapper::PolymorphicMapper.new([
            EmailAddressMapper.new,
            WebPageAddressMapper.new
          ])
          repository.mapper = OrganizationMapper.instance(
            address_mapper,
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
