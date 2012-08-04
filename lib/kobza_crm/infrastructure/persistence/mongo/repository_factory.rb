require 'mongobzar'

require 'kobza_crm/infrastructure/persistence/mongo/service_case_repository'
require 'kobza_crm/infrastructure/persistence/mongo/role_repository'
require 'kobza_crm/infrastructure/persistence/mongo/party_repository'

require 'kobza_crm/infrastructure/persistence/mongo/organization_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/person_assembler'

require 'kobza_crm/infrastructure/persistence/mongo/customer_role_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/customer_service_representative_role_assembler'

require 'kobza_crm/infrastructure/persistence/mongo/service_case_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/communication_thread_assembler'

require 'kobza_crm/infrastructure/persistence/mongo/email_address_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/web_page_address_assembler'

module KobzaCRM module Infrastructure module Persistence module Mongo

  class RepositoryFactory
    include Mongobzar::Assembler

    def initialize(database_name)
      @database_name = database_name

      @role_repository = RoleRepository.new(
        database_name, 'party_roles')

      @party_repository = PartyRepository.new(database_name, 'parties')

      @service_case_repository = ServiceCaseRepository.new(
        database_name, 'service_cases')

      @communication_thread_repository = Mongobzar::Repository::DependentRepository.new(
        database_name, 'communication_threads')
      @communication_thread_repository.foreign_key = 'service_case_id'

      @customer_role_assembler_base = CustomerRoleAssembler.new
      @customer_service_representative_role_assembler_base =
        CustomerServiceRepresentativeRoleAssembler.new

      @customer_role_assembler = InheritanceAssembler.new(
        Domain::CustomerRole, 'customer',
        EntityAssembler.new(@customer_role_assembler_base))

      @customer_service_representative_role_assembler =
        InheritanceAssembler.new(
          Domain::CustomerServiceRepresentativeRole,
          'customer_service_representative',
          EntityAssembler.new(
            @customer_service_representative_role_assembler_base))

      @role_assembler = PolymorphicAssembler.new([
        @customer_role_assembler,
        @customer_service_representative_role_assembler
      ])

      @person_assembler_base = PersonAssembler.new(address_assembler)
      @person_assembler = EntityAssembler.new(@person_assembler_base)

      @organization_assembler_base = OrganizationAssembler.new(
        address_assembler)
      @organization_assembler = EntityAssembler.new(
        @organization_assembler_base)

      @party_assembler = PolymorphicAssembler.new([
        InheritanceAssembler.new(
          Domain::Organization, 'organization',
            @organization_assembler),
        InheritanceAssembler.new(
          Domain::Person, 'person',
            @person_assembler)
      ])

      @service_case_assembler_base = ServiceCaseAssembler.new
      @service_case_assembler = EntityAssembler.new(
        @service_case_assembler_base)

      @communication_thread_assembler_base = CommunicationThreadAssembler.new
      @communication_thread_assembler = EntityAssembler.new(
        @communication_thread_assembler_base)

      @role_repository.assembler = @role_assembler
      @party_repository.assembler = @party_assembler
      @service_case_repository.assembler = @service_case_assembler
      @communication_thread_repository.assembler = @communication_thread_assembler
      @service_case_repository.communication_thread_repository =
        @communication_thread_repository

      @customer_role_assembler_base.party_source =
        @party_repository

      @customer_service_representative_role_assembler_base.party_source =
        @party_repository

      @person_assembler_base.role_source = @role_repository
      @organization_assembler_base.role_source = @role_repository

      @service_case_assembler_base.role_source = @role_repository
      @service_case_assembler_base.communication_threads_source =
        @communication_thread_repository
    end

    attr_reader :role_repository,
      :party_repository,
      :service_case_repository

    private
      attr_reader :database_name

      def email_address_assembler
        InheritanceAssembler.new(
          Domain::EmailAddress, 'email',
          ValueObjectAssembler.new(
            EmailAddressAssembler.new))
      end

      def web_page_address_assembler
        InheritanceAssembler.new(
          Domain::WebPageAddress, 'web_page',
          ValueObjectAssembler.new(
            WebPageAddressAssembler.new))
      end

      def address_assembler
        PolymorphicAssembler.new([
          email_address_assembler,
          web_page_address_assembler
        ])
      end
  end
end end end end
