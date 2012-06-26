module KobzaCRM
  module Persistence
    class InheritanceMappingStrategy
      def build_domain_object!(role, dto)
      end

      def build_new(dto)
        domain_object_class.new
      end

      def build_dto!(dto, role)
        dto['type'] = type_code
      end
    end
  end
end
