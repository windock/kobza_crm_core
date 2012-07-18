require 'kobza_crm/domain/email_address'
require 'kobza_crm/no_public_new'

module KobzaCRM module Persistence module Mongo
  class EmailAddressMapper < Mongobzar::Mapper::Mapper
    include NoPublicNew

    def self.instance
      Mongobzar::Mapper::InheritanceMapper.new(
        Domain::EmailAddress, 'email',
        Mongobzar::Mapper::ValueObjectMapper.new(new))
    end

    def build_dto!(dto, address)
      dto['email_address'] = address.email_address
    end

    def build_new(dto)
      Domain::EmailAddress.new(dto['email_address'])
    end
  end
end end end
