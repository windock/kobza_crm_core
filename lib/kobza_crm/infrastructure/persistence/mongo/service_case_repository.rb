require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class ServiceCaseRepository < Mongobzar::Repository::Repository
    def update(service_case)
      super
      communication_thread_repository.update_dependent_collection(service_case, service_case.communication_threads)
    end

    def clear_everything!
      super
      communication_thread_repository.clear_everything!
    end

    attr_accessor :communication_thread_repository
  end
end end end end
