require 'kobza_crm/domain/email_address'

module KobzaCRM module Persistence module Mongo
  class EmailAddressAssembler < Mongobzar::Assembler::Assembler
    def self.instance
      Mongobzar::Assembler::InheritanceAssembler.new(
        Domain::EmailAddress, 'email',
        Mongobzar::Assembler::ValueObjectAssembler.new(new))
    end

    def build_dto!(dto, address)
      dto['email_address'] = address.email_address
    end

    def build_new(dto)
      Domain::EmailAddress.new(dto['email_address'])
    end
  end
end end end
