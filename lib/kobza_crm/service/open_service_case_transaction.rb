require 'kobza_crm/domain/service_case'

module KobzaCRM module Service
  class OpenServiceCaseTransaction
    def initialize(title, brief_description, raised_by,
                   service_case_repository)
      @title = title
      @brief_description = brief_description
      @raised_by = raised_by
      @repository = service_case_repository
    end

    def execute
      csc = Domain::ServiceCase.new(title, brief_description, raised_by)
      repository.insert(csc)
    end

    private
      attr_reader :title, :brief_description, :raised_by, :repository
  end
end end
