shared_examples 'a party' do
  it 'may have multiple addresses' do
    address1 = stub
    address2 = stub

    subject.add_address(address1)
    subject.add_address(address2)

    subject.addresses.should == [address1, address2]
  end
end
