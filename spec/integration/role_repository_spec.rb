require 'mongobzar'

require 'kobza_crm/domain/person'
require 'kobza_crm/domain/customer_role'
require 'kobza_crm/infrastructure/persistence/mongo/customer_role_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/customer_service_representative_role_assembler'
require 'kobza_crm/infrastructure/persistence/mongo/role_repository'
require 'kobza_crm/infrastructure/persistence/mongo/repository_factory'

require_relative 'shared_examples_for_mongo_repository'

module KobzaCRM module Infrastructure module Persistence module Mongo module Test
  include Mongobzar::Assembler
  describe RoleRepository do
    include_context 'a mongo repository context'

    let(:collection_name) { 'party_roles' }
    let(:party) do
      Domain::Person.new('person_name1')
    end

    let(:customer_role) do
      res = Domain::CustomerRole.new
      res.customer_value = customer_value
      res
    end

    let(:customer_service_representative_role) do
      res = Domain::CustomerServiceRepresentativeRole.new
      res
    end

    let(:repository_factory) { RepositoryFactory.new(database_name) }

    let(:customer_role_assembler) do
      InheritanceAssembler.new(
        Domain::CustomerRole, 'customer',
        EntityAssembler.new(CustomerRoleAssembler.new(party_repository)))
    end

    let(:customer_service_representative_role_assembler) do
      InheritanceAssembler.new(
        Domain::CustomerServiceRepresentativeRole, 'customer_service_representative',
        EntityAssembler.new(CustomerServiceRepresentativeRoleAssembler.new(party_repository)))
    end

    let(:role_assembler) do
      PolymorphicAssembler.new([
        customer_role_assembler,
        customer_service_representative_role_assembler
      ])
    end

    let(:repository) do
      role_repository = RoleRepository.new(
        database_name, 'party_roles')
      role_repository.assembler = role_assembler
      role_repository
    end

    let(:party_repository) do
      repository_factory.party_repository
    end

    let(:customer_value) { 3 }

    describe '#find_for_party' do
      context 'given party is persisted and
        multiple roles are added to it' do

        let(:role1) { customer_role }
        let(:role2) { customer_service_representative_role }

        before do
          party_repository.insert(party)
          party.add_role(role1)
          party.add_role(role2)
        end

        context 'after roles are inserted' do
          before do
            repository.insert(role1)
            repository.insert(role2)
          end

          it 'returns all roles for a given party' do
            roles = repository.find_for_party(party)

            roles.should have(2).items
            roles[0].id.should == role1.id
            roles[0].party.should == party

            roles[1].id.should == role2.id
            roles[1].party.should == party
          end
        end
      end
    end

    context 'given party is persisted and role is added to a it' do
      before do
        party_repository.insert(party)
        party.add_role(role)
      end

      describe '#find' do
        context 'given role is inserted' do
          before do
            repository.insert(role)
          end

          describe 'finds role by it\'s id and loads it' do
            let(:found_role) { repository.find(role.id) }
            subject { found_role }

            context 'where role is CustomerRole' do
              let(:role) { customer_role }

              its(:id) { should == role.id }
              its(:name) { should == role.name }
              its(:party) { should == role.party }
              its(:customer_value) { should == role.customer_value }
            end

            context 'where role is CustomerServiceRepresentativeRole' do
              let(:role) { customer_service_representative_role }

              its(:id) { should == role.id }
              its(:name) { should == role.name }
              its(:party) { should == role.party }
            end
          end
        end
      end

      describe '#insert' do
        describe 'persists it as document' do
          before do
            repository.insert(role)
          end
          subject { document }

          context 'where role is CustomerRole' do
            let(:role) { customer_role }

            its(['type']) { should == 'customer' }
            its(['party_id']) { should == party.id }
            its(['customer_value']) { should == customer_value }
          end

          context 'where role is CustomerServiceRepresentativeRole' do
            let(:role) { customer_service_representative_role }

            its(['type']) { should == 'customer_service_representative' }
            its(['party_id']) { should == party.id }
          end
        end
      end
    end
  end
end end end end end
