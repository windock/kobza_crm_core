require 'mongobzar'
require 'kobza_crm/persistence/person_mapper'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'
require_relative 'shared_examples_for_mongo_party_repository'

module KobzaCRM
  module Persistence
    module Tests
      describe PartyRepository do
        subject { repository }
        let(:repository) do
          repository = PartyRepository.new(database_name, collection_name)
          repository.mapper = PersonMapper.instance(
            AddressMapper.instance,
            RoleRepository.instance(database_name, collection_name)
          )
          repository
        end

        let(:collection_name) { 'people' }

        let(:party) { Person.new(sample_name) }
        let(:other_party) { Person.new('bill') }

        it_behaves_like 'a mongo party repository'
      end
    end
  end
end
