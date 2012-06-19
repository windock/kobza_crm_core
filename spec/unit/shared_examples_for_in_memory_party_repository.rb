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

          describe 'returns all of the loaded, which' do
            it 'are equal' do
              subject.all.should == [party, other_party]
            end

            it 'are different objects every time' do
              all1 = subject.all
              all2 = subject.all

              all1[0].should_not be_equal(all2[0])
              all1[1].should_not be_equal(all2[1])
            end
          end
        end
      end

      describe '#find' do
        context 'given party is added' do
          before do
            subject.add(party)
          end

          describe 'returns party by id which' do
            it 'is equal' do
              subject.find(next_id).should == party
            end

            it 'is different object every time' do
              subject.find(next_id).should_not be_equal(subject.find(next_id))
            end
          end
        end
      end

      describe '#update' do
        context 'when a party was already added' do
          before do
            subject.add(party)
          end

          context 'when a party with the id of added is updated' do
            it 'replaces existing with provided' do
              party.name = 'New name'
              subject.update(party)

              subject.find(party.id).should == party
            end
          end
        end
      end

      describe '#add' do
        before do
          subject.add(party)
        end

        describe 'adds new party' do
          it 'which is equal' do
            subject.all.should == [party]
          end
        end

        it 'sets new id' do
          party.id.should == next_id
        end
      end
      describe '#update' do
        context 'when a party was already added' do
          before do
            subject.add(party)
          end

          context 'when a party with the id of added is updated' do
            it 'replaces existing with provided' do
              party.name = 'New name'
              subject.update(party)

              subject.find(party.id).should == party
            end
          end
        end
      end

    end
  end
end
