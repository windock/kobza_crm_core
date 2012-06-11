require 'kobza_crm/bson_id_generator'

module KobzaCRM
  module Test
    describe BSONIdGenerator do
      context '#next_id' do
        it 'generates unique ids' do
          subject.next_id.should_not == subject.next_id
        end

        it 'generatos BSON::ObjectId' do
          subject.next_id.should be_kind_of(BSON::ObjectId)
        end
      end
    end
  end
end
