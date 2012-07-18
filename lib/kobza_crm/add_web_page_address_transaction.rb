require 'kobza_crm/domain/web_page_address'

module KobzaCRM
  class AddWebPageAddressTransaction
    def initialize(person_id, url, person_repository)
      @person_repository = person_repository
      @person_id = person_id
      @url = url
    end

    def execute
      person = @person_repository.find(@person_id)
      person.add_address(Domain::WebPageAddress.new(@url))

      @person_repository.update(person)
    end
  end
end
