require 'kobza_crm/no_public_new'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'

module KobzaCRM
  module Persistence
    class AddressMapper
      include NoPublicNew
      def self.instance
        Mongobzar::Mapper::PolymorphicMapper.new([
          EmailAddressMapper.new,
          WebPageAddressMapper.new
        ])
      end
    end

    class EmailAddressMapper < Mongobzar::Mapper::ValueObjectMapper
      def type_code
        'email'
      end

      def build_dto!(dto, address)
        dto['type'] = type_code
        dto['email_address'] = address.email_address
      end

      def build_new(dto)
        domain_object_class.new(dto['email_address'])
      end

      def domain_object_class
        EmailAddress
      end
    end

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
