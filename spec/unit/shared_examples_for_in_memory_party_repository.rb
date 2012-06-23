require_relative 'shared_examples_for_in_memory_repository'

module KobzaCRM
  module Test
    shared_examples 'an in memory party repository' do
      let(:domain_object) { party }
      let(:other_domain_object) { other_party }

      it_behaves_like 'an in memory repository'

      def update_domain_object(party)
        party.name = 'New name'
      end
    end
  end
end
