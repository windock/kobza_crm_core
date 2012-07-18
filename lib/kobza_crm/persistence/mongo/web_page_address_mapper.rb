require 'kobza_crm/domain/web_page_address'

module KobzaCRM module Persistence module Mongo
  class WebPageAddressMapper < Mongobzar::Mapper::Mapper
    def self.instance
      Mongobzar::Mapper::InheritanceMapper.new(
        Domain::WebPageAddress, 'web_page',
        Mongobzar::Mapper::ValueObjectMapper.new(new)
      )
    end

    def build_dto!(dto, address)
      dto['url'] = address.url
    end

    def build_new(dto)
      Domain::WebPageAddress.new(dto['url'])
    end
  end

end end end