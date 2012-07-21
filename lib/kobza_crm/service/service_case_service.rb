module KobzaCRM module Service
  class ServiceCaseService
    def initialize(service_case_repository)
      @service_case_repository = service_case_repository
    end

    def open(title, brief_description, raised_by)
      sc = Domain::ServiceCase.new(title, brief_description, raised_by)
      service_case_repository.insert(sc)
    end

    private
      attr_reader :service_case_repository
  end
end end
