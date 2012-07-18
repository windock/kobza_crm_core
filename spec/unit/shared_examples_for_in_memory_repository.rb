module KobzaCRM module Test
  shared_context 'an in memory repository context' do
    let(:next_id) { 1 }
    let(:id_generator) { stub(next_id: next_id) }

    before do
      subject.id_generator = id_generator
    end
  end

  shared_examples 'an in memory repository' do
    include_context 'an in memory repository context'

    describe '#all' do
      context 'given 2 domain objects are added' do
        before do
          subject.insert(domain_object)
          id_generator.stub!(:next_id) { 2 }
          subject.insert(other_domain_object)
        end

        describe 'returns all of the loaded, which' do
          it 'are equal' do
            subject.all.should == [domain_object, other_domain_object]
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
      context 'given domain object is added' do
        before do
          subject.insert(domain_object)
        end

        describe 'returns domain_object by id which' do
          it 'is equal' do
            subject.find(next_id).should == domain_object
          end

          it 'is different object every time' do
            subject.find(next_id).should_not be_equal(subject.find(next_id))
          end
        end
      end
    end

    describe '#update' do
      context 'when a domain_object was already added' do
        before do
          subject.insert(domain_object)
        end

        context 'when a domain_object with the id of added is updated' do
          it 'replaces existing with provided' do
            update_domain_object(domain_object)
            subject.update(domain_object)

            subject.find(domain_object.id).should == domain_object
          end
        end
      end
    end

    describe '#add' do
      before do
        subject.insert(domain_object)
      end

      describe 'adds new domain_object' do
        it 'which is equal' do
          subject.all.should == [domain_object]
        end
      end

      it 'sets new id' do
        domain_object.id.should == next_id
      end
    end
  end

end end
