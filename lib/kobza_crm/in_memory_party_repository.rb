require 'kobza_crm/in_memory_repository'

module KobzaCRM
  class InMemoryPartyRepository < InMemoryRepository
    def update(entity)
      entity.roles.select do |role|
        role.id.nil?
      end.each do |role|
        role.id = id_generator.next_id
      end

      super
    end
  end
end
