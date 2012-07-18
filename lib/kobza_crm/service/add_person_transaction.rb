require 'kobza_crm/domain/person'

module KobzaCRM
  module Service
    class AddPersonTransaction
      def initialize(name, person_repository)
        @name = name
        @person_repository = person_repository
      end

      def execute
        @person = Domain::Person.new(@name)
        @person_repository.insert(@person)
      end

      attr_reader :person
    end
  end
end
