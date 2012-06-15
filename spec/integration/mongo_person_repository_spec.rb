require 'mongo'
require 'mongobzar'
require 'kobza_crm/persistence/mongo_person_repository'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'

require 'debugger'

module KobzaCRM
  module Persistence
    describe MongoPersonRepository do
      subject { MongoPersonRepository.new(id_generator, database_name) }
      let(:connection) { Mongo::Connection.new }
      let(:db) { connection.db(database_name) }
      let(:database_name) { 'kobza_crm_test' }
      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:person) { Person.new('bob') }
      let(:other_person) { Person.new('bill') }

      let(:sample_email_address) { 'test1@example.com' }
      let(:sample_url) { 'test1.example.com/page' }

      before do
        subject.clear_everything!
      end

      context '#all' do
        context 'given 2 people are saved' do
          before do
            subject.add(person)
            subject.add(other_person)
          end

          it 'returns all of them loaded' do
            subject.all.should == [person, other_person]
          end
        end
      end

      context '#find' do
        context 'given person is saved' do
          before do
            subject.add(person)
          end

          describe 'finds person by it\'s id and loads it' do
            let(:found_person) { subject.find(person.id) }

            it 'with id' do
              found_person.id.should == person.id
            end

            it 'with name' do
              found_person.name.should == person.name
            end
          end
        end

        context 'given person is saved with related' do
          context 'web page address' do
            describe 'it loads person with loaded address' do
              it 'with url' do
                web_page_address = WebPageAddress.new(sample_url)
                person.add_address(web_page_address)

                subject.add(person)

                found_person = subject.find(person.id)
                found_person.addresses[0].url.should == sample_url
              end
            end
          end

          context 'email address' do
            describe 'it loads person with loaded address do' do
              it 'with email_address' do
                email_address = EmailAddress.new(sample_email_address)
                person.add_address(email_address)

                subject.add(person)

                found_person = subject.find(person.id)
                found_person.addresses[0].email_address.should == sample_email_address
              end
            end
          end
        end
      end

      context '#add persists it' do

        before do
          subject.clear_everything!
          email_address = EmailAddress.new(sample_email_address)
          web_page_address = WebPageAddress.new(sample_url)

          person.add_address(email_address)
          person.add_address(web_page_address)

          subject.add(person)
          collection = db['people']
          @documents = collection.find.to_a
        end

        it 'as document' do
          @documents.size.should == 1
        end

        it 'with _id' do
          @documents[0]['_id'].should be_kind_of(BSON::ObjectId)
        end

        it 'with name' do
          @documents[0]['name'].should == 'bob'
        end

        it 'updates id of person' do
          person.id.should be_kind_of(BSON::ObjectId)
        end

        context 'given email address' do
          let(:email_addresses) do
            @documents[0]['addresses'].select do |a|
              a['type'] == 'email'
            end
          end

          describe 'it persists it' do
            it 'as 1 embedded document' do
              email_addresses.size.should == 1
            end

            it 'with email_address' do
              email_addresses[0]['email_address'].should == sample_email_address
            end

            it 'with type "email"' do
              email_addresses[0]['type'].should == 'email'
            end
          end
        end

        context 'given web page address' do
          let(:web_addresses) do
            @documents[0]['addresses'].select do |a|
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
      end
    end
  end
end
