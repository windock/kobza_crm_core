require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class RoleRepository < Mongobzar::Repository::Repository
    def find_for_party(party)
      dtos = mongo_collection.find('party_id' => party.id).to_a
      assembler.build_domain_objects(dtos)
    end
  end
end end end end
