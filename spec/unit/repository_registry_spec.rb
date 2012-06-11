require 'kobza_crm/repository_registry'

module KobzaCRM
  module Test
    describe RepositoryRegistry do
      it 'locates person repository' do
        person_repository = stub
        RepositoryRegistry.person_repository = person_repository
        RepositoryRegistry.person_repository.should == person_repository
      end
    end
  end
end

