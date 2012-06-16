require 'mongobzar'
require 'kobza_crm/persistence/mongo_person_repository'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'
require_relative 'shared_examples_for_party_repository'

module KobzaCRM
  module Persistence
    describe MongoPersonRepository do
      subject { MongoPersonRepository.new(id_generator, database_name) }
      let(:connection) { Mongo::Connection.new }
      let(:db) { connection.db(database_name) }
      let(:database_name) { 'kobza_crm_test' }
      let(:collection) { db['people'] }
      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:sample_name) { 'Bob' }
      let(:person) { Person.new(sample_name) }
      let(:party) { person }
      let(:other_person) { Person.new('bill') }
      let(:other_party) { Person.new('bill') }

      before do
        subject.clear_everything!
      end

      it_behaves_like 'a party repository'
    end
  end
end
