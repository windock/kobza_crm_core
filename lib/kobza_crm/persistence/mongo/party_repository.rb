require 'mongobzar'

module KobzaCRM module Persistence module Mongo
  class PartyRepository < Mongobzar::Repository::Repository
    def insert(party)
      super
      role_repository.insert_dependent_collection(party, party.roles)
    end

    def update(party)
      super
      role_repository.update_dependent_collection(party, party.roles)
    end

    def clear_everything!
      super
      role_repository.clear_everything!
    end

    attr_accessor :role_repository
  end
end end end
