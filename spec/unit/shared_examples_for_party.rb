shared_examples 'a party' do
  it 'may have multiple addresses' do
    address1 = stub
    address2 = stub

    subject.add_address(address1)
    subject.add_address(address2)

    subject.addresses.should == [address1, address2]
  end

  it 'allows change of name' do
    subject.name = 'new_name'
    subject.name.should == 'new_name'
  end

  context 'cloned party' do
    it 'has full copy of addresses' do
      address = Struct.new(:value).new('original')
      subject.add_address(address)

      cloned = subject.dup
      subject.addresses.first.value = 'other'

      cloned.addresses.first.value.should == 'original'
    end
  end
end
