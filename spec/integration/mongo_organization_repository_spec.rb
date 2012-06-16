require 'debugger'
require 'mongobzar'
require 'kobza_crm/persistence/mongo_organization_repository'
require_relative 'shared_examples_for_party_repository'

module KobzaCRM
  module Persistence
    describe MongoOrganizationRepository do
      subject { MongoOrganizationRepository.new(id_generator, database_name) }

      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:database_name) { 'kobza_crm_test' }
      let(:collection) { db['organizations'] }
      let(:sample_email_address) { 'test1@example.com' }
      let(:sample_name) { 'Orga' }
      let(:organization) { Organization.new(sample_name) }
      let(:party) { organization }
      let(:other_party) { Organization.new('Bobka') }
      let(:connection) { Mongo::Connection.new }
      let(:db) { connection.db(database_name) }

      before do
        subject.clear_everything!
      end

      it_behaves_like 'a party repository'

      describe '#add' do
        include_context '#add'
      end
    end
  end
end
