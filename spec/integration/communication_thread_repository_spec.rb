require 'kobza_crm/domain/service_case'
require 'kobza_crm/domain/communication_thread'

require 'kobza_crm/infrastructure/persistence/mongo/repository_factory'

require_relative 'shared_examples_for_mongo_repository'

module KobzaCRM module Infrastructure module Persistence module Mongo module Test
  include Domain

  describe ServiceCaseRepository do
    include_context 'a mongo repository context'
    let(:repository_factory) do
      RepositoryFactory.new(database_name)
    end
    let(:service_case_repository) do
      repository_factory.service_case_repository
    end
    let(:repository) { service_case_repository }
    let(:service_case) do
      ServiceCase.new('title1', 'desc1', person.roles.first)
    end
    let(:role) { CustomerRole.new }
    let(:person) do
      person = Person.new('person-name1')
      person.add_role(role)
      person
    end
    let(:thread1) { CommunicationThread.new }
    let(:thread2) { CommunicationThread.new }

    let(:communication_thread_collection) do
      db['communication_threads']
    end

    let(:communication_thread_documents) do
      communication_thread_collection.find.to_a
    end

    context 'given ServiceCase is added' do
      let(:topics) { ['topic1', 'topic2'] }
      let(:descriptions) { ['desc1', 'desc2'] }

      before do
        repository_factory.party_repository.insert(person)
        repository_factory.role_repository.insert(role)
        service_case_repository.insert(service_case)
      end

      describe '#find' do
        context 'given ServiceCase is added with 2 CommunicationThreads' do
          before do
            service_case.start_communication_thread(topics[0], descriptions[0])
            service_case.start_communication_thread(topics[1], descriptions[1])
            service_case_repository.update(service_case)
          end

          describe 'it loads ServiceCase with related
              CommunicationThreads' do
            let(:found_service_case) do
              service_case_repository.find(service_case.id)
            end
            subject { found_service_case }

            its(:communication_threads) { should have(2).items }

            describe 'CommunicationThreads are loaded' do
              subject { found_service_case.communication_threads[0] }
              its(:brief_description) { should == descriptions[0] }
              its(:topic_name) { should == topics[0] }
            end
          end
        end
      end

      describe '#update' do
        context 'when ServiceCase is updated
            with 2 CommunicationThreads' do
          before do
            service_case.start_communication_thread(topics[0], descriptions[0])
            service_case.start_communication_thread(topics[1], descriptions[1])
            service_case_repository.update(service_case)
          end

          describe 'persists them' do
            subject { communication_thread_documents[0] }
            it 'as 2 documents' do
              communication_thread_documents.should have(2).items
            end

            its(['_id']) { should be_kind_of(BSON::ObjectId) }
            its(['service_case_id']) { should == service_case.id }
            its(['topic_name']) { should == topics[0] }
            its(['brief_description']) { should == descriptions[0] }
          end
        end
      end
    end
  end
end end end end end
