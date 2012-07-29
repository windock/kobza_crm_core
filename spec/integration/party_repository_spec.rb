require 'kobza_crm/domain/email_address'
require 'kobza_crm/domain/web_page_address'
require 'kobza_crm/domain/customer_role'
require 'kobza_crm/infrastructure/persistence/mongo/party_repository'
require 'kobza_crm/infrastructure/persistence/mongo/repository_factory'

require_relative 'shared_examples_for_mongo_repository'

module KobzaCRM module Infrastructure module Persistence module Mongo module Test
  shared_examples 'party repository' do
    include_context 'a mongo repository context'

    let(:collection_name) { 'parties' }

    subject { repository }
    let(:repository_factory) do
      RepositoryFactory.new(database_name)
    end
    let(:repository) do
      repository_factory.party_repository
    end
    let(:role_repository) do
      repository_factory.role_repository
    end

    let(:domain_object) { party }
    let(:other_domain_object) { other_party }
    it_behaves_like 'a mongo repository'

    let(:sample_url) { 'test1.example.com/page' }
    let(:sample_email) { 'test1@example.com' }
    let(:sample_name) { 'SampleName' }

    describe '#find' do
      context 'given party is added' do
        before do
          repository.insert(party)
        end

        describe 'finds party by it\'s id and loads it' do
          let(:found_party) { repository.find(party.id) }
          subject { found_party }

          its(:id) { should == party.id }
          its(:name) { should == party.name }
        end
      end

      context 'given party is added with related' do
        context 'role' do
          before do
            role_repository.clear_everything!
            party.add_role(role)
            repository.insert(party)
            role_repository.insert(role)
          end

          let(:found_party) { repository.find(party.id) }
          let(:found_role) { found_party.roles.first }

          context 'CustomerServiceRepresentativeRole' do
            let(:role) { Domain::CustomerServiceRepresentativeRole.new }

            describe 'it loads party with loaded roles' do
              subject { found_role }
              its(:name) { should == 'customer_service_representative' }
              its(:party) { should == party }
            end
          end

          context 'CustomerRole' do
            let(:role) do
              role = Domain::CustomerRole.new
              role.customer_value = 3
              role
            end

            describe 'it loads party with loaded roles' do
              subject { found_role }
              its(:name) { should == 'customer' }
              its(:customer_value) { should == 3 }
              its(:party) { should == party }
            end
          end
        end

        context 'web page address' do
          describe 'it loads party with loaded address' do
            it 'with url' do
              web_page_address = Domain::WebPageAddress.new(sample_url)
              party.add_address(web_page_address)

              repository.insert(party)

              found_party = repository.find(party.id)
              found_party.addresses[0].url.should == sample_url
            end
          end
        end

        context 'email address' do
          describe 'it loads party with loaded address do' do
            it 'with email_address' do
              email_address = Domain::EmailAddress.new(sample_email)
              party.add_address(email_address)

              repository.insert(party)

              found_party = repository.find(party.id)
              found_party.addresses[0].email_address.should == sample_email
            end
          end
        end
      end
    end

    describe '#update' do
      context 'when a party was already added' do
        before do
          repository.insert(party)
        end

        context 'when a party with the id of added is updated' do
          it 'replaces a document with the same id' do
            party.name = 'New name'
            repository.update(party)

            document['name'].should == 'New name'
          end
        end
      end
    end

    describe '#insert' do
      context 'without associations' do
        before do
          repository.insert(party)
        end

        describe 'persists it as document' do
          subject { document }
          its(['name']) { should == sample_name }
        end
      end

      context 'with web page address' do
        before do
          web_page_address = Domain::WebPageAddress.new(sample_url)
          party.add_address(web_page_address)
          repository.insert(party)
        end

        let(:web_address_documents) do
          document['addresses'].select do |a|
            a['type'] == 'web_page'
          end
        end

        describe 'it persists it' do
          subject { web_address_documents[0] }
          it 'as 1 embedded document' do
            web_address_documents.size.should == 1
          end
          its(['url']) { should == sample_url }
          its(['type']) { should == 'web_page' }
        end
      end

      context 'with email address' do
        before do
          email_address = Domain::EmailAddress.new(sample_email)
          party.add_address(email_address)
          repository.insert(party)
        end

        let(:email_address_documents) do
          document['addresses'].select do |a|
            a['type'] == 'email'
          end
        end

        describe 'it persists it' do
          subject { email_address_documents[0] }
          it 'as 1 embedded document' do
            email_address_documents.size.should == 1
          end
          its(['email_address']) { should == sample_email }
          its(['type']) { should == 'email' }
        end
      end
    end
  end

  describe PartyRepository do
    context 'when party is an Organization' do
      let(:party) { Domain::Organization.new(sample_name) }
      let(:other_party) { Domain::Organization.new('Bobka') }

      it_behaves_like 'party repository'
    end

    context 'when party is a Person' do
      let(:party) { Domain::Person.new(sample_name) }
      let(:other_party) { Domain::Person.new('Bobka') }

      it_behaves_like 'party repository'
    end
  end
end end end end end
