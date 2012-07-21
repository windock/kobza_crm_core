require_relative 'shared_examples_for_in_memory_repository'
require 'kobza_crm/infrastructure/persistence/memory/party_repository'
require 'kobza_crm/domain/person'
require 'kobza_crm/domain/customer_role'

module KobzaCRM module Infrastructure module Persistence module Memory module Test
  describe PartyRepository do
    let(:domain_object) { Domain::Person.new('p1') }
    let(:other_domain_object) { Domain::Person.new('p2') }
    let(:party) { domain_object }

    include_context 'an in memory repository'
    it_behaves_like 'an in memory repository'

    def update_domain_object(party)
      party.name = 'New name'
    end
    subject { PartyRepository.new }

    describe '#update' do
      context 'when a party was already added' do
        before do
          subject.insert(party)
        end

        context 'when a party with id of added is updated' do
          #TODO: the same should be done for adding
          context 'with new role' do
            let(:role) { Domain::CustomerRole.new }

            before do
              party.add_role(role)
              subject.update(party)
            end

            it 'sets new id for the role' do
              role.id.should == next_id
            end
          end
        end
      end
    end
  end
end end end end end
