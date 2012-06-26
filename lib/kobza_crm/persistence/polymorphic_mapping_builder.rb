module KobzaCRM
  module Persistence
    class PolymorphicMappingBuilder
      def initialize(mappers)
        @mappers = mappers
      end

      def build_dto!(dto, domain_object)
        mapper_for_domain_object(domain_object).build_dto!(dto, domain_object)
      end

      def build_new(dto)
        mapper_for_dto(dto).build_new(dto)
      end

      def build_domain_object!(role, dto)
        mapper_for_dto(dto).build_domain_object!(role, dto)
      end

      protected
        def mapper_for_dto(dto)
          @mappers.each do |mapper|
            return mapper if mapper.type_code == dto['type']
          end
        end

        def mapper_for_domain_object(role)
          @mappers.each do |mapper|
            return mapper if role.kind_of?(mapper.domain_object_class)
          end
        end
    end
  end
end
