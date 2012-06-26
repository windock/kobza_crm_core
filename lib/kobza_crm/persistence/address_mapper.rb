require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'
require 'kobza_crm/persistence/inheritance_mapper'
require 'kobza_crm/persistence/inheritance_mapping_builder'

module KobzaCRM
  module Persistence
    class AddressMapper < Mongobzar::Mapping::EmbeddedMapper
      include NoPublicNew

      def initialize
        @mapping_builder = InheritanceMappingBuilder.new([
          EmailAddressMapper.new,
          WebPageAddressMapper.new
        ])
      end

      def build_dto!(dto, address)
        @mapping_builder.build_dto!(dto, address)
      end

      def build_new(dto)
        @mapping_builder.build_new(dto)
      end
    end

    class EmailAddressMapper < InheritanceMapper
      def type_code
        'email'
      end

      def build_dto!(dto, address)
        super
        dto['email_address'] = address.email_address
      end

      def build_new(dto)
        domain_object_class.new(dto['email_address'])
      end

      def domain_object_class
        EmailAddress
      end
    end

    class WebPageAddressMapper < InheritanceMapper
      def type_code
        'web_page'
      end

      def build_dto!(dto, address)
        super
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
