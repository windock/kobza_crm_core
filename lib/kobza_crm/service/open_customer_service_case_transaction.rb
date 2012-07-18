require 'kobza_crm/domain/customer_service_case'

module KobzaCRM module Service
  class OpenCustomerServiceCaseTransaction
    def initialize(title, brief_description, raised_by,
                   customer_service_case_repository)
      @title = title
      @brief_description = brief_description
      @raised_by = raised_by
      @repository = customer_service_case_repository
    end

    def execute
      csc = Domain::CustomerServiceCase.new(title, brief_description, raised_by)
      repository.insert(csc)
    end

    private
      attr_reader :title, :brief_description, :raised_by, :repository
  end
end end
