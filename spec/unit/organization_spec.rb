require 'kobza_crm/organization'

module KobzaCRM
  module Test
    describe Organization do
      it 'may be created, given name' do
        sample_name = 'Orga'
        Organization.new(sample_name).name.should == sample_name
      end
    end
  end
end
