require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'

module KobzaCRM
  module Persistence
    class AddressMapper < Mongobzar::Mapping::EmbeddedMapper
      def build_dto!(dto, address)
        if address.kind_of?(EmailAddress)
          dto['email_address'] = address.email_address
          dto['type'] = 'email'
        elsif address.kind_of?(WebPageAddress)
          dto['url'] = address.url
          dto['type'] = 'web_page'
        end
      end

      def build_new(dto={})
        if dto['type'] == 'web_page'
          WebPageAddress.new(dto['url'])
        elsif dto['type'] == 'email'
          EmailAddress.new(dto['email_address'])
        end
      end
    end
  end
end
