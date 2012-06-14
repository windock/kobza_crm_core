require 'kobza_crm/in_memory_person_repository'
require 'kobza_crm/person'

module KobzaCRM
  module Test
    describe InMemoryPersonRepository do
      let(:subject) { InMemoryPersonRepository.new(id_generator) }
      let(:next_id) { 1 }
      let(:id_generator) { stub(next_id: next_id) }
      let(:new_person) { Person.new('bob') }

      context '#add' do
        it 'adds new person' do
          subject.add(new_person)
          subject.all.should == [new_person]
        end

        it 'sets new id' do
          subject.add(new_person)
          new_person.id.should == next_id
        end
      end

      context '#find' do
        it 'allows to find a person by id' do
          subject.add(new_person)
          subject.find(next_id).should == new_person
        end
      end
    end
  end
end
