require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class ServiceCaseAssembler < Mongobzar::Assembler::Assembler
    def initialize(role_source)
      @role_source = role_source
    end

    def build_new(dto)
      role = role_source.find(dto['role_id'])
      Domain::ServiceCase.new(dto['title'], dto['brief_description'], role)
    end

    private
      attr_reader :role_source

  end
end end end end
