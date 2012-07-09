require 'kobza_crm/web_page_address'

module KobzaCRM
  module Persistence
    class WebPageAddressMapper < Mongobzar::Mapper::ValueObjectMapper
      def type_code
        'web_page'
      end

      def build_dto!(dto, address)
        dto['type'] = type_code
        dto['url'] = address.url
      end

      def build_new(dto)
        domain_object_class.new(dto['url'])
      end

      def domain_object_class
        WebPageAddress
      end
    end

  end
end
