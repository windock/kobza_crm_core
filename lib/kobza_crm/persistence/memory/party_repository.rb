require 'kobza_crm/persistence/memory/repository'

module KobzaCRM module Persistence module Memory
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
end end end
