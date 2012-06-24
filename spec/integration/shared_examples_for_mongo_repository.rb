module KobzaCRM
  module Persistence
    module Test
      shared_context 'a mongo repository context' do
        let(:id_generator) { Mongobzar::BSONIdGenerator.new }
        let(:connection) { Mongo::Connection.new }
        let(:db) { connection.db(database_name) }
        let(:database_name) { 'kobza_crm_test' }

        let(:documents) { collection.find.to_a }
        let(:document) { documents[0] }
        let(:collection) { db[collection_name] }

        before do
          repository.clear_everything!
        end
      end

      shared_examples 'a mongo repository' do
        include_context 'a mongo repository context'

        describe '#all' do
          context 'given 2 domain objects are added' do
            before do
              subject.add(domain_object)
              subject.add(other_domain_object)
            end

            it 'returns all of them loaded' do
              subject.all.should == [domain_object, other_domain_object]
            end
          end
        end

        describe '#add' do
          context 'without associations' do
            before do
              subject.add(domain_object)
            end

            it 'updates id' do
              domain_object.id.should be_kind_of(BSON::ObjectId)
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
    end
  end
end
