require 'mongobzar'

require 'kobza_crm/infrastructure/persistence/mongo/service_case_repository'
require 'kobza_crm/infrastructure/persistence/mongo/dependent_role_repository'
require 'kobza_crm/infrastructure/persistence/mongo/party_repository'

require 'kobza_crm/infrastructure/persistence/mongo/organization_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/person_assembler'

require 'kobza_crm/infrastructure/persistence/mongo/dependent_customer_role_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/dependent_customer_service_representative_role_assembler'

require 'kobza_crm/infrastructure/persistence/mongo/email_address_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/web_page_address_assembler'

module KobzaCRM module Infrastructure module Persistence module Mongo

  class RepositoryFactory
    include Mongobzar::Assembler

    def initialize(database_name)
      @database_name = database_name
    end

    def role_repository
      role_repository = DependentRoleRepository.new(
        database_name, 'party_roles')
      role_repository.assembler = role_assembler
      role_repository.foreign_key = 'party_id'
      role_repository
    end

    def party_repository
      repository = PartyRepository.new(database_name, 'parties')
      repository.role_repository = role_repository
      repository.assembler = party_assembler
      repository
    end

    def service_case_repository
      repository = ServiceCaseRepository.new(database_name, 'service_cases')
      repository.assembler = service_case_assembler
      repository
    end

    private
      attr_reader :database_name

      def customer_role_assembler
        InheritanceAssembler.new(
          Domain::CustomerRole, 'customer',
          EntityAssembler.new(DependentCustomerRoleAssembler.new))
      end

      def customer_service_representative_role_assembler
        InheritanceAssembler.new(
          Domain::CustomerServiceRepresentativeRole,
          'customer_service_representative',
          EntityAssembler.new(
            DependentCustomerServiceRepresentativeRoleAssembler.new))
      end

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

      def organization_assembler(address_assembler, role_assembler)
        EntityAssembler.new(
          OrganizationAssembler.new(address_assembler, role_assembler))
      end

      def person_assembler(address_assembler, role_assembler)
        EntityAssembler.new(
          PersonAssembler.new(address_assembler, role_assembler))
      end

      def address_assembler
        PolymorphicAssembler.new([
          email_address_assembler,
          web_page_address_assembler
        ])
      end

      def party_assembler
        PolymorphicAssembler.new([
          InheritanceAssembler.new(
            Domain::Organization, 'organization',
              organization_assembler(
                address_assembler,
                role_repository)),
          InheritanceAssembler.new(
            Domain::Person, 'person',
              person_assembler(
                address_assembler,
                role_repository
              ))
        ])
      end

      def role_assembler
        PolymorphicAssembler.new([
          customer_role_assembler,
          customer_service_representative_role_assembler
        ])
      end

      def service_case_assembler
        EntityAssembler.new(
          ServiceCaseAssembler.new(role_repository))
      end
  end
end end end end