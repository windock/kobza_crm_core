require 'kobza_crm/no_public_new'

module KobzaCRM module Persistence module Memory
  class Repository
    attr_accessor :id_generator
    include NoPublicNew

    def initialize
      @entities = {}
    end

    def insert(entity)
      id = id_generator.next_id
      entity.id = id
      entities[id] = entity.dup
    end

    def update(entity)
      entities[entity.id] = entity
    end

    def all
      entities.values.map(&:dup)
    end

    def find(id)
      entities[id].dup
    end

    def id_generator
      @id_generator ||= Mongobzar::Utility::BSONIdGenerator.new
    end

    private
      attr_reader :entities

  end
end end end
