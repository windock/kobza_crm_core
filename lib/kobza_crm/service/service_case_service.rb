require 'kobza_crm/domain/service_case'

module KobzaCRM module Service
  class ServiceCaseService
    def initialize(service_case_repository)
      @service_case_repository = service_case_repository
    end

    def open_service_case(title, brief_description, raised_by)
      sc = Domain::ServiceCase.new(title, brief_description, raised_by)
      service_case_repository.insert(sc)
    end

    def start_communication_thread(service_case_id, topic_name,
                                   brief_description)
      service_case = service_case_repository.find(service_case_id)
      service_case.start_communication_thread(topic_name,
                                              brief_description)
      service_case_repository.update(service_case)
    end

    private
      attr_reader :service_case_repository
  end
end end
