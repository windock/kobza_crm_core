module KobzaCRM
  module Test
    shared_examples 'an in memory party repository' do
      let(:next_id) { 1 }
      let(:id_generator) { stub(next_id: next_id) }

      describe '#all' do
        context 'given 2 parties are added' do
          before do
            subject.add(party)
            id_generator.stub!(:next_id) { 2 }
            subject.add(other_party)
          end

          it 'returns all of the loaded' do
            subject.all.should == [party, other_party]
          end
        end
      end

      describe '#add' do
        before do
          subject.add(party)
        end

        it 'adds new party' do
          subject.all.should == [party]
        end

        it 'sets new id' do
          party.id.should == next_id
        end
      end

      describe '#find' do
        context 'given party is added' do
          before do
            subject.add(party)
          end

          it 'allows to find a person by id' do
            subject.find(next_id).should == party
          end
        end
      end
    end

    shared_context 'an in memory party repository context' do
    end
  end
end
