module KobzaCRM module Service
  class PartyService
    def initialize(party_repository)
      @party_repository = party_repository
    end

    def add_person(name)
      person = Domain::Person.new(name)
      party_repository.insert(person)
      person
    end

    def add_organization(name)
      organization = Domain::Organization.new(name)
      party_repository.insert(organization)
      organization
    end

    def add_email_address(party_id, email_address)
      party = party_repository.find(party_id)
      party.add_address(Domain::EmailAddress.new(email_address))

      party_repository.update(party)
    end

    def add_web_page_address(party_id, url)
      party = party_repository.find(party_id)
      party.add_address(Domain::WebPageAddress.new(url))

      party_repository.update(party)
    end

    def make_customer(party_id, customer_value)
      role = Domain::CustomerRole.new
      role.customer_value = customer_value
      party = party_repository.find(party_id)
      party.add_role(role)
      party_repository.update(party)
    end

    def make_customer_service_representative(party_id)
      role = Domain::CustomerServiceRepresentativeRole.new
      party = party_repository.find(party_id)
      party.add_role(role)
      party_repository.update(party)
    end

    private
      attr_reader :party_repository
  end
end end
