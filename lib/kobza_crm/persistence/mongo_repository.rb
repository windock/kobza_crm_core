module KobzaCRM
  module Persistence
    class MongoRepository
      def add(domain_object)
        @mapper.insert(domain_object)
      end

      def find(id)
        @mapper.find(id)
      end

      def update(domain_object)
        @mapper.update(domain_object)
      end

      def all
        @mapper.all
      end

      def clear_everything!
        @mapper.clear_everything!
      end
    end
  end
end
