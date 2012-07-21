require 'kobza_crm/infrastructure/persistence/memory/repository'

module KobzaCRM module Infrastructure module Persistence module Memory
  class PartyRepository < Repository
    def update(entity)
      entity.roles.select do |role|
        role.id.nil?
      end.each do |role|
        role.id = id_generator.next_id
      end

      super
    end
  end
end end end end
