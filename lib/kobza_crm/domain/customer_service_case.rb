module KobzaCRM module Domain
  class CustomerServiceCase
    attr_reader :short_description, :raised_by
    attr_accessor :id
    attr_accessor :title

    def initialize(title, short_description, raised_by)
      @title = title
      @short_description = short_description
      @raised_by = raised_by
    end

    def ==(o)
      id == o.id &&
      title == o.title &&
      short_description == o.short_description &&
      raised_by == o.raised_by
    end
  end
end end
