require 'kobza_crm/organization_repository'

module KobzaCRM
  module Test
    describe OrganizationRepository do
      let(:subject) { OrganizationRepository.new(id_generator) }
      let(:next_id) { 1 }
      let(:id_generator) { stub(next_id: next_id) }
      let(:new_organization) { Struct.new(:id).new }

      context '#add' do
        it 'adds new organization' do
          subject.add(new_organization)
          subject.all.should == [new_organization]
        end

        it 'sets new id' do
          subject.add(new_organization)
          new_organization.id.should == next_id
        end
      end

      context '#find' do
        it 'allows to find an organization by id' do
          subject.add(new_organization)
          subject.find(next_id).should == new_organization
        end
      end
    end
  end
end
