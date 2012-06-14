require 'mongo'
require 'mongobzar'
require 'kobza_crm/persistence/mongo_person_repository'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'

require 'debugger'

module KobzaCRM
  module Persistence
    describe MongoPersonRepository do
      context '#add inserts a document' do
        let(:connection) { Mongo::Connection.new }
        let(:db) { connection.db(database_name) }
        let(:database_name) { 'kobza_crm_test' }
        let(:id_generator) { Mongobzar::BSONIdGenerator.new }
        let(:subject) { MongoPersonRepository.new(id_generator, database_name) }
        let(:sample_email_address) { 'test1@example.com' }
        let(:sample_url) { 'test1.example.com/page' }
        let(:new_person) { Person.new('bob') }

        before(:all) do
          subject.clear_everything!
          email_address = EmailAddress.new(sample_email_address)
          web_page_address = WebPageAddress.new(sample_url)

          new_person.add_address(email_address)
          new_person.add_address(web_page_address)

          subject.add(new_person)
          collection = db['people']
          @documents = collection.find.to_a
        end

        it 'only 1' do
          @documents.size.should == 1
        end

        it 'with _id' do
          @documents[0]['_id'].should be_kind_of(BSON::ObjectId)
        end

        it 'with name' do
          @documents[0]['name'].should == 'bob'
        end

        it 'updates id of person' do
          new_person.id.should be_kind_of(BSON::ObjectId)
        end

        it 'uses id of IdGenerator' do
          pending
        end

        context 'with addresses' do
          context 'with email addresses' do
            let(:email_addresses) do
              @documents[0]['addresses'].select do |a|
                a['type'] == 'email'
              end
            end

            it 'only 1' do
              email_addresses.size.should == 1
            end

            it 'with email_address' do
              email_addresses[0]['email_address'].should == sample_email_address
            end
          end

          context 'with web addresses' do
            let(:web_addresses) do
              @documents[0]['addresses'].select do |a|
                a['type'] == 'web_page'
              end
            end

            it 'only 1' do
              web_addresses.size.should == 1
            end

            it 'with url' do
              web_addresses[0]['url'].should == sample_url
            end
          end
        end
      end
    end
  end
end
