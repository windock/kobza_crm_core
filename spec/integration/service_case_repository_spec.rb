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
    let(:party_repository) do
      repository_factory.party_repository
    end
    subject { repository }

    let(:person) do
      person = Person.new('person-name1')
      person.add_role(CustomerRole.new)
      person
    end
    #let(:customer) { CustomerRole.new }

    let(:service_case) { ServiceCase.new('title1', 'desc1', person.roles.first) }
    let(:service_case2) { ServiceCase.new('title2', 'desc2', person.roles.first) }
    #it_behaves_like 'a mongo repository'

    describe '#all' do
      context 'given 2 service cases are added' do
        before do
          party_repository.insert(person)

          subject.insert(service_case)
          subject.insert(service_case2)
        end

        it 'returns all of them loaded' do
          r1 =  [service_case, service_case2]
          pending
          subject.all.should == [service_case, service_case2]
        end
      end
    end

    describe '#insert' do
      context 'without associations' do
        before do
          subject.insert(service_case)
        end

        it 'updates id' do
          service_case.id.should be_kind_of(BSON::ObjectId)
        end

        describe 'persists it as' do
          it 'single document' do
            documents.size.should == 1
          end

          describe 'document' do
            it 'with _id' do
              document['_id'].should be_kind_of(BSON::ObjectId)
            end
          end
        end
      end
    end
  end
end end end end end
