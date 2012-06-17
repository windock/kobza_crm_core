module KobzaCRM
  class InMemoryRepository
    def initialize(id_generator)
      @id_generator = id_generator
      @entities = {}
    end

    def add(entity)
      id = @id_generator.next_id
      entity.id = id
      @entities[id] = entity.dup
    end

    def update(entity)
      @entities[entity.id] = entity
    end

    def all
      @entities.values.map(&:dup)
    end

    def find(id)
      @entities[id].dup
    end
  end
end
