require 'kobza_crm/email_address'

module KobzaCRM
  module Test
    describe EmailAddress do
      it 'may be created with email address' do
        sample_email_address = 'test1@example.com'
        email_address = EmailAddress.new(sample_email_address)
        email_address.email_address.should == sample_email_address
      end
    end
  end
end
