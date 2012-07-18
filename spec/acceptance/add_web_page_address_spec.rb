require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  # As a user,
  # I want to add web page address to the party,
  # so that I may contact it later
  describe AddWebPageAddressTransaction do
    let(:person_repository) { Persistence::Memory::Repository.instance }
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

      web_page_address.should be_kind_of(Domain::WebPageAddress)
      web_page_address.url.should == sample_url
    end
  end
end end end
