require 'kobza_crm/in_memory_customer_service_case_repository'
require 'kobza_crm/customer_service_case'
require_relative 'shared_examples_for_in_memory_repository'

module KobzaCRM
  module Test
    describe InMemoryCustomerServiceCaseRepository do
      subject do
        InMemoryCustomerServiceCaseRepository.instance(id_generator)
      end

      let(:domain_object) do
        CustomerServiceCase.new('title', 'description', stub)
      end

      let(:other_domain_object) do
        CustomerServiceCase.new('title2', 'description', stub)
      end

      def update_domain_object(customer_service_case)
        customer_service_case.title = 'other title'
      end

      it_behaves_like 'an in memory repository'
    end
  end
end
