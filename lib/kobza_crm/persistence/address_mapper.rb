require 'kobza_crm/no_public_new'
require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'
require 'kobza_crm/persistence/inheritance_mapping_strategy'
require 'kobza_crm/persistence/polymorphic_mapping_strategy'

module KobzaCRM
  module Persistence
    class AddressMapper < Mongobzar::Mapping::EmbeddedMapper
      include NoPublicNew
      attr_reader :mapping_strategy

      def initialize
        @mapping_strategy = PolymorphicMappingStrategy.new([
          EmailAddressMappingStrategy.new,
          WebPageAddressMappingStrategy.new
        ])
      end
    end

    class EmailAddressMappingStrategy < InheritanceMappingStrategy
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

    class WebPageAddressMappingStrategy < InheritanceMappingStrategy
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
