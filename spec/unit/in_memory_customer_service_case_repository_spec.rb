require 'kobza_crm/persistence/memory/customer_service_case_repository'
require 'kobza_crm/domain/customer_service_case'
require_relative 'shared_examples_for_in_memory_repository'

module KobzaCRM module Persistence module Memory module Test
  describe CustomerServiceCaseRepository do
    subject do
      CustomerServiceCaseRepository.instance
    end

    let(:domain_object) do
      Domain::CustomerServiceCase.new('title', 'description', stub)
    end

    let(:other_domain_object) do
      Domain::CustomerServiceCase.new('title2', 'description', stub)
    end

    def update_domain_object(customer_service_case)
      customer_service_case.title = 'other title'
    end

    it_behaves_like 'an in memory repository'
  end
end end end end
