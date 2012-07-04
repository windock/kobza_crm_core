require 'kobza_crm'
require 'mongobzar'

module KobzaCRM
  module Test
    # As a user,
    # I want to add web page address to the party,
    # so that I may contact it later
    describe AddWebPageAddressTransaction do
      let(:id_generator) { Mongobzar::Utility::BSONIdGenerator.new }
      let(:person_repository) { InMemoryPersonRepository.instance(id_generator) }
      let(:sample_url) { 'http://sample.example.com' }

      before do
        t = AddPersonTransaction.new('Bob', person_repository)
        t.execute
        @person_id = t.person.id

        t = AddWebPageAddressTransaction.new(@person_id, sample_url, person_repository)
        t.execute
      end

      it 'adds WebPageAddress to Person' do
        addresses = person_repository.find(@person_id).addresses
        web_page_address = addresses.first

        web_page_address.should be_kind_of(WebPageAddress)
        web_page_address.url.should == sample_url
      end
    end
  end
end
