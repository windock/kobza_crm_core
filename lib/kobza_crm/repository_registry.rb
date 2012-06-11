require 'kobza_crm/person_repository'

module KobzaCRM
  class RepositoryRegistry
    def self.person_repository=(person_repository)
      @person_repository = person_repository
    end

    def self.person_repository
      @person_repository
    end
  end
end
