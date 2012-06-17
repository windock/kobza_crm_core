require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    describe AddWebPageAddressTransaction do
      let(:id_generator) { Mongobzar::BSONIdGenerator.new }
      let(:person_repository) { InMemoryPersonRepository.new(id_generator) }
      let(:sample_url) { 'http://sample.example.com' }

      before do
        t = AddPersonTransaction.new('Bob', person_repository)
        t.execute
        @person_id = t.person.id

        t = AddWebPageAddressTransaction.new(@person_id, sample_url, person_repository)
        t.execute
      end

      it 'add WebPageAddress to Person' do
        addresses = person_repository.find(@person_id).addresses
        web_page_address = addresses.first

        web_page_address.should be_kind_of(WebPageAddress)
        web_page_address.url.should == sample_url
      end
    end
  end
end
