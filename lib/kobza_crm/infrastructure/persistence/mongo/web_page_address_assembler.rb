require 'kobza_crm/domain/web_page_address'

module KobzaCRM module Infrastructure module Persistence module Mongo
  class WebPageAddressAssembler < Mongobzar::Assembler::Assembler
    def build_dto!(dto, address)
      dto['url'] = address.url
    end

    def build_new(dto)
      Domain::WebPageAddress.new(dto['url'])
    end
  end

end end end end
