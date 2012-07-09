require 'kobza_crm/email_address'

module KobzaCRM
  module Persistence
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
  end
end
