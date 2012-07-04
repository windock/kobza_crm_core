module KobzaCRM
  class AddOrganizationTransaction
    def initialize(name, organization_repository)
      @name = name
      @organization_repository = organization_repository
    end

    def execute
      @organization = Organization.new(@name)
      @organization_repository.insert(organization)
    end

    attr_reader :organization
  end
end
