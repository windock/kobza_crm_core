require 'bson'

module KobzaCRM
  class BSONIdGenerator
    def next_id
      BSON::ObjectId.new
    end
  end
end
