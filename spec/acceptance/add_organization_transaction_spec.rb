require 'kobza_crm'

module KobzaCRM
  module Service
    module Test
      # As a user,
      # I want to add Organization
      # so that I may keep track of it
      describe AddOrganizationTransaction do
        before do
          @organization_repository = InMemoryOrganizationRepository.instance
        end

        let(:sample_name) { 'Orga' }

        it 'adds Organization to OrganizationRepository' do
          t = AddOrganizationTransaction.new(sample_name, @organization_repository)
          t.execute

          orga = @organization_repository.all.first
          orga.name.should == sample_name
        end

        it 'provides organization with set id after execution' do
          t = AddOrganizationTransaction.new(sample_name, @organization_repository)
          t.execute

          organization = t.organization
          organization.id.should_not be_nil
          organization.name.should == sample_name
        end
      end
    end
  end
end
