module KobzaCRM module Infrastructure
  class RepositoryRegistry
    def self.person_repository=(person_repository)
      @person_repository = person_repository
    end

    def self.person_repository
      @person_repository
    end
  end
end end
