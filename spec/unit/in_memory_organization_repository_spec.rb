require 'kobza_crm/in_memory_organization_repository'
require 'kobza_crm/domain/organization'
require_relative 'shared_examples_for_in_memory_party_repository'

module KobzaCRM
  module Test
    describe InMemoryOrganizationRepository do
      subject { InMemoryOrganizationRepository.instance }

      it_behaves_like 'an in memory party repository'

      let(:party) { Domain::Organization.new('Orga') }
      let(:other_party) { Domain::Organization.new('Borka') }
    end
  end
end
