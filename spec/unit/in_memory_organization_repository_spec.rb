require 'kobza_crm/persistence/memory/organization_repository'
require 'kobza_crm/domain/organization'
require_relative 'shared_examples_for_in_memory_party_repository'

module KobzaCRM module Persistence module Memory module Test
  describe OrganizationRepository do
    subject { OrganizationRepository.instance }

    it_behaves_like 'an in memory party repository'

    let(:party) { Domain::Organization.new('Orga') }
    let(:other_party) { Domain::Organization.new('Borka') }
  end
end end end end
