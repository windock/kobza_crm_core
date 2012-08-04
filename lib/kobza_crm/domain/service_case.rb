require 'kobza_crm/domain/communication_thread'

module KobzaCRM module Domain
  class ServiceCase
    attr_reader :brief_description, :raised_by
    attr_accessor :id
    attr_accessor :title

    def initialize(title, brief_description, raised_by)
      @title = title
      @brief_description = brief_description
      @raised_by = raised_by
      @communication_threads = []
    end

    def ==(o)
      id == o.id &&
      title == o.title &&
      brief_description == o.brief_description &&
      raised_by == o.raised_by
    end

    def start_communication_thread(topic_name, brief_description)
      thread = CommunicationThread.new
      thread.topic_name = topic_name
      thread.brief_description = brief_description
      add_communication_thread(thread)
    end

    def add_communication_thread(thread)
      communication_threads << thread
    end

    attr_reader :communication_threads
  end
end end
