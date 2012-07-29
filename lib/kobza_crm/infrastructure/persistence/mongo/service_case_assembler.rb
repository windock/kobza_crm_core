require 'mongobzar'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class ServiceCaseAssembler < Mongobzar::Assembler::Assembler
    attr_writer :role_source

    def build_new(dto)
      role = role_source.find(dto['role_id'])
      Domain::ServiceCase.new(dto['title'], dto['brief_description'], role)
    end

    def build_dto!(dto, service_case)
      dto['role_id'] = service_case.raised_by.id
      dto['title'] = service_case.title
      dto['brief_description'] = service_case.brief_description
    end

    private
      attr_reader :role_source

  end
end end end end
