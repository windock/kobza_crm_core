require 'kobza_crm/web_page_address'
require 'kobza_crm/no_public_new'

module KobzaCRM
  module Persistence
    class WebPageAddressMapper < Mongobzar::Mapper::Mapper
      include NoPublicNew

      def self.instance
        Mongobzar::Mapper::InheritanceMapper.new(
          WebPageAddress, 'web_page',
          Mongobzar::Mapper::ValueObjectMapper.new(new)
        )
      end

      def build_dto!(dto, address)
        dto['url'] = address.url
      end

      def build_new(dto)
        WebPageAddress.new(dto['url'])
      end
    end

  end
end
