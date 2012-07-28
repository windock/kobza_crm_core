require 'kobza_crm/domain/person'
require 'kobza_crm/domain/customer_role'
require 'kobza_crm/infrastructure/persistence/mongo/dependent_role_repository'
require 'kobza_crm/infrastructure/persistence/mongo/repository_factory'

require_relative 'shared_examples_for_mongo_repository'

module KobzaCRM module Infrastructure module Persistence module Mongo module Test
  describe DependentRoleRepository do
    include_context 'a mongo repository context'
    let(:party) do
      Domain::Person.new('person_name1')
    end

    let(:role) do
      res = Domain::CustomerRole.new
      res
    end

    let(:repository_factory) { RepositoryFactory.new(database_name) }

    let(:repository) do
      repository_factory.role_repository
    end

    let(:party_repository) do
      repository_factory.party_repository
    end

    context 'given party is persisted' do
      before do
        party_repository.insert(party)
      end

      describe '#find' do
        context 'given role is added to a party' do
          before do
            party.add_role(role)
            party_repository.update(party)
          end

          context 'given role is added' do
            #before do
              #repository.insert(role)
            #end

            #describe 'finds role by it\'s id and loads it' do
              #let(:found_role) { repository.find(role.id) }
              #subject { found_role }

              #its(:id) { should == role.id }
              #its(:name) { should == role.name }
            #end
          end
        end
      end
    end
  end
end end end end end
