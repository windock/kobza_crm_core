require 'kobza_crm/domain/email_address'

module KobzaCRM
  module Test
    describe Domain::EmailAddress do
      it 'may be created with email address' do
        sample_email_address = 'test1@example.com'
        email_address = Domain::EmailAddress.new(sample_email_address)
        email_address.email_address.should == sample_email_address
      end
    end
  end
end
