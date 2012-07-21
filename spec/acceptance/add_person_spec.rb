require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  describe PartyService do
    let(:party_repository) do
      Infrastructure::Persistence::Memory::RepositoryFactory.new.party_repository
    end

    subject { PartyService.new(party_repository) }
    let(:sample_name) { 'Bob' }

    # As a user,
    # I want to add a person,
    # so that I may keep track of it
    describe '#add_person' do
      it 'adds Person to PartyRepository' do
        subject.add_person(sample_name)

        person = party_repository.all.first
        person.name.should == sample_name
      end

      it 'returns added person with set id' do
        person = subject.add_person(sample_name)
        person.id.should_not be_nil
        person.name.should == sample_name
      end
    end
  end
end end end
