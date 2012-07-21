require 'kobza_crm'
require 'mongobzar'

module KobzaCRM module Service module Test
  describe PartyService do
    let(:party_repository) do
      Infrastructure::Persistence::Memory::RepositoryFactory.new.party_repository
    end

    subject { PartyService.new(party_repository) }
    let(:sample_name) { 'Bob' }

    # As a user,
    # I want to add a person,
    # so that I may keep track of it
    describe '#add_person' do
      it 'adds Person to PartyRepository' do
        subject.add_person(sample_name)

        person = party_repository.all.first
        person.name.should == sample_name
      end

      it 'returns added person with set id' do
        person = subject.add_person(sample_name)
        person.id.should_not be_nil
        person.name.should == sample_name
      end
    end

    # As a user,
    # I want to add Organization
    # so that I may keep track of it
    describe '#add_organization' do
      it 'adds Organization to PartyRepository' do
        subject.add_organization(sample_name)
        orga = party_repository.all.first
        orga.name.should == sample_name
      end

      it 'returns added organization with set id' do
        orga = subject.add_organization(sample_name)
        orga.id.should_not be_nil
        orga.name.should == sample_name
      end
    end

    # As a user,
    # I want to add email address to the party,
    # so that I may contact it later by email
    describe '#add_email_address' do
      before do
        @person = subject.add_person(sample_name)
      end
      let(:sample_email) { 'test1@example.com' }

      it 'adds EmailAddress to Party' do
        subject.add_email_address(@person.id, sample_email)

        addresses = party_repository.find(@person.id).addresses
        email_address = addresses.first

        email_address.email_address.should == sample_email
      end
    end

    # As a user,
    # I want to add web page address to the party,
    # so that I may contact it later
    describe '#add_web_page_address' do
      let(:sample_url) { 'http://sample.example.com' }

      before do
        @party = subject.add_person(sample_name)
      end

      it 'adds WebPageAddress to Person' do
        subject.add_web_page_address(@party.id, sample_url)
        web_page_address = party_repository.find(@party.id).
          addresses.first
        web_page_address.url.should == sample_url
      end
    end

    # As a user,
    # I want to make some party a customer,
    # so that I may treat it like one
    describe '#make_customer' do
      let(:customer_value) { 3 }

      before do
        @party = subject.add_person(sample_name)
        subject.make_customer(@party.id, customer_value)
        found_party = party_repository.find(@party.id)
        @role = found_party.roles.first
      end

      it 'adds CustomerRole role to the Party' do
        @role.customer_value.should == 3
      end

      it 'sets id for the added role' do
        @role.id.should_not be_nil
      end
    end


    # As a user,
    # I want to make some person a customer service representative,
    # so that I may treat it like one
    describe '#make_customer_service_representative' do
      before do
        @party = subject.add_person('Bob')
        subject.make_customer_service_representative(@party.id)
        found_party = party_repository.find(@party.id)
        @role = found_party.roles.first
      end

      it 'adds CustomerServiceRepresentativeRole role to the party' do
        @role.should be_kind_of(Domain::CustomerServiceRepresentativeRole)
      end

      it 'sets id for the added role' do
        @role.id.should_not be_nil
      end
    end
  end
end end end
