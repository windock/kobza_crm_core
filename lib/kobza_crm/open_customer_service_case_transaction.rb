module KobzaCRM
  class OpenCustomerServiceCaseTransaction
    def initialize(title, brief_description, raised_by,
                   customer_service_case_repository)
      @title = title
      @brief_description = brief_description
      @raised_by = raised_by
      @customer_service_case_repository = customer_service_case_repository
    end

    def execute
      csc = CustomerServiceCase.new(title, brief_description, raised_by)
      @customer_service_case_repository.insert(csc)
    end
  end
end
