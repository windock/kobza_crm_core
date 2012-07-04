require_relative 'shared_examples_for_in_memory_repository'

module KobzaCRM
  module Test
    shared_examples 'an in memory party repository' do
      let(:domain_object) { party }
      let(:other_domain_object) { other_party }

      include_context 'an in memory repository'
      it_behaves_like 'an in memory repository'

      def update_domain_object(party)
        party.name = 'New name'
      end

      describe '#update' do
        context 'when a party was already added' do
          before do
            subject.insert(party)
          end

          context 'when a party with id of added is updated' do
            #TODO: the same should be done for adding
            context 'with new role' do
              let(:role) { CustomerRole.new }

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
  end
end
