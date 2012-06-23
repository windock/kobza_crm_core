require_relative 'shared_examples_for_has_identity'

shared_examples 'party role' do
  it_behaves_like 'has identity'

  it 'may be have party associated' do
    party = stub
    subject.party = party
    subject.party.should == party
  end
end
