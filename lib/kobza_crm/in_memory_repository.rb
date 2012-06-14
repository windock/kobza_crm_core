module KobzaCRM
  class InMemoryRepository
    def initialize(id_generator)
      @id_generator = id_generator
      @entities = {}
    end

    def add(entity)
      id = @id_generator.next_id
      entity.id = id
      @entities[id] = entity
    end

    def all
      @entities.values
    end

    def find(id)
      @entities[id]
    end
  end
end
