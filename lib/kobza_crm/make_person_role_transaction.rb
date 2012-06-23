module KobzaCRM
  class MakePersonRoleTransaction
    def initialize(person_id, person_repository)
      @person_repository = person_repository
      @person_id = person_id
    end

    def execute
      person = @person_repository.find(@person_id)

      person.add_role(build_role)

      @person_repository.update(person)
    end
  end
end
