module KobzaCRM
  module Persistence
    class InheritanceMapper
      def build_domain_object!(role, dto)
      end

      def build_new(dto)
        self.class.domain_object_class.new
      end

      def build_dto!(dto, role)
        dto['type'] = self.class.type_code
      end
    end
  end
end
