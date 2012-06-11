require 'kobza_crm/web_page_address'

module KobzaCRM
  module Test
    describe WebPageAddress do
      it 'may be created with url' do
        sample_url = 'sample.example.cokm'

        web_page_address = WebPageAddress.new(sample_url)
        web_page_address.url.should == sample_url
      end
    end
  end
end
