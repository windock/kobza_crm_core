require 'kobza_crm'

module KobzaCRM
  module Test
    describe AddWebPageAddressTransaction do
      before do
        id_generator = BSONIdGenerator.new
        @person_repository = InMemoryPersonRepository.new(id_generator)
        t = AddPersonTransaction.new('Bob', @person_repository)
        t.execute
        @person = t.person
      end

      it 'add WebPageAddress to Person' do
        sample_url = 'http://sample.example.com'
        t = AddWebPageAddressTransaction.new(@person.id, sample_url, @person_repository)
        t.execute

        @person.addresses.first.url.should == sample_url
      end
    end
  end
end
