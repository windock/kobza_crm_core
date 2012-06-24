require 'kobza_crm/email_address'
require 'kobza_crm/web_page_address'
require 'kobza_crm/persistence/inheritance_mapper'

module KobzaCRM
  module Persistence
    class EmailAddressMapper < InheritanceMapper
      def self.type_code
        'email'
      end

      def build_dto!(dto, address)
        super
        dto['email_address'] = address.email_address
      end

      def build_new(dto)
        self.class.domain_object_class.new(dto['email_address'])
      end

      def self.domain_object_class
        EmailAddress
      end
    end

    class WebPageAddressMapper < InheritanceMapper
      def self.type_code
        'web_page'
      end

      def build_dto!(dto, address)
        super
        dto['url'] = address.url
      end

      def build_new(dto)
        self.class.domain_object_class.new(dto['url'])
      end

      def self.domain_object_class
        WebPageAddress
      end
    end

    class AddressMapper < Mongobzar::Mapping::EmbeddedMapper
      def initialize
        @e_mapper = EmailAddressMapper.new
        @wp_mapper = WebPageAddressMapper.new
      end

      def build_dto!(dto, address)
        mapper_for_domain_object(address).build_dto!(dto, address)
      end

      def build_new(dto)
        mapper_for_dto(dto).build_new(dto)
      end

      protected
        def mapper_for_domain_object(address)
          case address
          when EmailAddressMapper.domain_object_class then @e_mapper
          when WebPageAddressMapper.domain_object_class then @wp_mapper
          end
        end

        def mapper_for_dto(dto)
          case dto['type']
          when EmailAddressMapper.type_code then @e_mapper
          when WebPageAddressMapper.type_code then @wp_mapper
          end
        end
    end
  end
end
