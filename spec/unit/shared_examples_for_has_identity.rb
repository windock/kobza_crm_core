module KobzaCRM module Domain module Test
  shared_examples 'has identity' do
    it 'may have an identity' do
      id = stub
      subject.id = id
      subject.id.should == id
    end
  end
end end end
