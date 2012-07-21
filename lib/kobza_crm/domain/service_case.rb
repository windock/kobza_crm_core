module KobzaCRM module Domain
  class ServiceCase
    attr_reader :brief_description, :raised_by
    attr_accessor :id
    attr_accessor :title

    def initialize(title, brief_description, raised_by)
      @title = title
      @brief_description = brief_description
      @raised_by = raised_by
    end

    def ==(o)
      id == o.id &&
      title == o.title &&
      brief_description == o.brief_description &&
      raised_by == o.raised_by
    end
  end
end end
