require 'kobza_crm/infrastructure/persistence/mongo/repository_factory'
require 'kobza_crm/infrastructure/persistence/mongo/service_case_assembler'
require 'kobza_crm/domain/service_case'
require 'kobza_crm/domain/person'
require 'kobza_crm/domain/customer_role'
require_relative 'shared_examples_for_mongo_repository'

module KobzaCRM module Infrastructure module Persistence module Mongo module Test
  include Domain

  describe ServiceCaseRepository do

    include_context 'a mongo repository context'

    let(:collection_name) { 'service_cases' }
    let(:repository_factory) { RepositoryFactory.new(database_name) }
    let(:repository) do
      repository_factory.service_case_repository
    end
    let(:party_repository) { repository_factory.party_repository }
    let(:role_repository) { repository_factory.role_repository }

    subject { repository }
    let(:role) { CustomerRole.new }

    let(:person) do
      person = Person.new('person-name1')
      person.add_role(role)
      person
    end

    let(:service_case) do
      ServiceCase.new('title1', 'desc1', person.roles.first)
    end
    let(:service_case2) do
      ServiceCase.new('title2', 'desc2', person.roles.first)
    end

    context 'given there is a party with role persisted' do
      before do
        party_repository.clear_everything!
        role_repository.clear_everything!

        party_repository.insert(person)
        role_repository.insert(role)
      end

      describe '#all' do
        context 'given 2 service cases are inserted' do
          before do
            repository.insert(service_case)
            repository.insert(service_case2)
          end

          it 'returns all of them loaded' do
            repository.all.should == [service_case, service_case2]
          end
        end
      end

      describe '#find' do
        context 'given a service case is inserted' do
          before do
            repository.insert(service_case)
          end

          describe 'finds service case by it\'s id and loads it' do
            let(:found_service_case) { repository.find(service_case.id) }
            subject { found_service_case }

            its(:id) { should == service_case.id }
            its(:title) { should == service_case.title }
            its(:brief_description) { should == service_case.brief_description }
            its(:raised_by) { should == service_case.raised_by }
          end
        end
      end

      describe '#insert' do
        before do
          repository.insert(service_case)
        end

        it 'updates id' do
          service_case.id.should be_kind_of(BSON::ObjectId)
        end

        describe 'persists it as document' do
          it 'single document' do
            documents.size.should == 1
          end

          subject { document }
          its(['_id']) { should be_kind_of(BSON::ObjectId) }

          describe 'role_id' do
            subject { document['role_id'] }
            it { should be_kind_of(BSON::ObjectId) }
            it { should == role.id }
          end
        end
      end
    end
  end
end end end end end
