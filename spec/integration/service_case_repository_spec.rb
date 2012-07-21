require 'kobza_crm/infrastructure/persistence/mongo/service_case_repository'
require 'kobza_crm/infrastructure/persistence/mongo/service_case_assembler'
require 'kobza_crm/domain/service_case'
require 'kobza_crm/domain/person'
require 'kobza_crm/domain/customer_role'
require_relative 'shared_examples_for_mongo_repository'

module KobzaCRM module Infrastructure module Persistence module Mongo module Test
  include Domain

  describe ServiceCaseRepository do

    include_context 'a mongo repository context'

    let(:collection_name) { 'service_cases' }
    let(:repository) do
      RepositoryFactory.new(database_name).service_case_repository
    end
    subject { repository }

    let(:person) do
      person = Person.new('person-name1')
      person.add_role(CustomerRole.new)
      person
    end
    let(:customer) { CustomerRole.new }

    let(:domain_object) { ServiceCase.new('title1', 'desc1', person.roles.first) }
    let(:other_domain_object) { ServiceCase.new('title2', 'desc2', person.roles.first) }
    #it_behaves_like 'a mongo repository'
  end
end end end end end
