shared_examples 'party role' do
  it 'may be have party associated' do
    party = stub
    subject.party = party
    subject.party.should == party
  end
end
