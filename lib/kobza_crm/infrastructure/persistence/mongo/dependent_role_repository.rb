require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class DependentRoleRepository < Mongobzar::Repository::DependentRepository
    def find(id)
      assembler.build_domain_object(find_dto(id))
    end

    def find_dto(id)
      if id.kind_of?(String)
        id = BSON::ObjectId.from_string(id)
      end
      res = mongo_collection.find_one('_id' => id)
      raise Mongobzar::Repository::DocumentNotFound unless res
      res
    end
  end
end end end end
