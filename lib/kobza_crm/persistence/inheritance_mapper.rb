module KobzaCRM
  module Persistence
    class InheritanceMapper < Mongobzar::Mapper::EntityMapper
      def initialize(domain_object_class, type_code)
        @domain_object_class = domain_object_class
        @type_code = type_code
      end

      def build_new(dto)
        domain_object_class.new
      end

      def build_dto!(dto, role)
        dto['type'] = type_code
      end

      attr_reader :domain_object_class, :type_code
    end
  end
end
