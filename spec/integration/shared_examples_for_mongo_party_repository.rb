require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'

module KobzaCRM
  module Persistence
    shared_examples 'a mongo party repository' do
      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:connection) { Mongo::Connection.new }
      let(:db) { connection.db(database_name) }
      let(:database_name) { 'kobza_crm_test' }

      let(:sample_url) { 'test1.example.com/page' }
      let(:sample_email) { 'test1@example.com' }
      let(:sample_name) { 'SampleName' }
      let(:documents) { collection.find.to_a }
      let(:document) { documents[0] }
      let(:collection) { db[collection_name] }

      before do
        subject.clear_everything!
      end

      describe '#all' do
        context 'given 2 party objects are saved' do
          before do
            subject.add(party)
            subject.add(other_party)
          end

          it 'returns all of them loaded' do
            subject.all.should == [party, other_party]
          end
        end
      end

      describe '#find' do
        context 'given party is saved' do
          before do
            subject.add(party)
          end

          describe 'finds party by it\'s id and loads it' do
            let(:found_party) { subject.find(party.id) }

            it 'with id' do
              found_party.id.should == party.id
            end

            it 'with name' do
              found_party.name.should == party.name
            end
          end
        end

        context 'given party is saved with related' do
          context 'web page address' do
            describe 'it loads party with loaded address' do
              it 'with url' do
                web_page_address = WebPageAddress.new(sample_url)
                party.add_address(web_page_address)

                subject.add(party)

                found_party = subject.find(party.id)
                found_party.addresses[0].url.should == sample_url
              end
            end
          end

          context 'email address' do
            describe 'it loads party with loaded address do' do
              it 'with email_address' do
                email_address = EmailAddress.new(sample_email)
                party.add_address(email_address)

                subject.add(party)

                found_party = subject.find(party.id)
                found_party.addresses[0].email_address.should == sample_email
              end
            end
          end
        end
      end

      describe '#add' do
        context 'without associations' do
          before do
            subject.add(party)
          end

          it 'updates id' do
            party.id.should be_kind_of(BSON::ObjectId)
          end

          describe 'persists it as' do
            it 'single document' do
              documents.size.should == 1
            end

            describe 'document' do
              it 'with _id' do
                document['_id'].should be_kind_of(BSON::ObjectId)
              end

              it 'with name' do
                document['name'].should == sample_name
              end
            end
          end
        end

        context 'with web page address' do
          before do
            web_page_address = WebPageAddress.new(sample_url)
            party.add_address(web_page_address)
            subject.add(party)
          end

          let(:web_addresses) do
            document['addresses'].select do |a|
              a['type'] == 'web_page'
            end
          end

          describe 'it persists it' do
            it 'as 1 embedded document' do
              web_addresses.size.should == 1
            end

            it 'with url' do
              web_addresses[0]['url'].should == sample_url
            end

            it 'with type "web_page"' do
              web_addresses[0]['type'].should == 'web_page'
            end
          end
        end

        context 'with email address' do
          before do
            email_address = EmailAddress.new(sample_email)
            party.add_address(email_address)
            subject.add(party)
          end

          let(:email_addresses) do
            document['addresses'].select do |a|
              a['type'] == 'email'
            end
          end

          describe 'it persists it' do
            it 'as 1 embedded document' do
              email_addresses.size.should == 1
            end

            it 'with email_address' do
              email_addresses[0]['email_address'].should == sample_email
            end

            it 'with type "email"' do
              email_addresses[0]['type'].should == 'email'
            end
          end
        end
      end
    end
  end
end
