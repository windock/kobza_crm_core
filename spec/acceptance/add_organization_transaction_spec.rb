require 'kobza_crm'

module KobzaCRM
  module Test
    describe AddOrganizationTransaction do
      before do
        id_generator = BSONIdGenerator.new
        @organization_repository = InMemoryOrganizationRepository.new(id_generator)
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
