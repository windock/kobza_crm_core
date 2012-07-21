require 'kobza_crm/infrastructure/persistence/memory/party_repository'

module KobzaCRM module Infrastructure module Persistence module Memory
  class RepositoryFactory
    def role_repository
      Repository.new
    end

    def party_repository
      PartyRepository.new
    end

    def service_case_repository
      Repository.new
    end
  end
end end end end
