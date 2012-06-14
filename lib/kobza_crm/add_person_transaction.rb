require 'kobza_crm/repository_registry'
require 'kobza_crm/person'

module KobzaCRM
  class AddPersonTransaction
    def initialize(name, person_repository)
      @name = name
      @person_repository = person_repository
    end

    def execute
      @person = Person.new(@name)
      @person_repository.add(@person)
    end

    attr_reader :person
  end
end