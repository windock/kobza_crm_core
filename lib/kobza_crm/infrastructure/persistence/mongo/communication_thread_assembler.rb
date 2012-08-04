require 'kobza_crm/domain/communication_thread'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class CommunicationThreadAssembler
    def build_new(dto)
      Domain::CommunicationThread.new
    end

    def build_dto!(dto, thread)
      dto['topic_name'] = thread.topic_name
      dto['brief_description'] = thread.brief_description
    end

    def build_domain_object!(thread, dto)
      thread.brief_description = dto['brief_description']
      thread.topic_name = dto['topic_name']
    end
  end
end end end end
