module KobzaCRM
  module Persistence
    class PolymorphicMappingStrategy
      def initialize(mappers)
        @mappers = mappers
      end

      def build_dto(domain_object)
        mapper_for_domain_object(domain_object).build_dto(domain_object)
      end

      def build_dtos(domain_objects)
        domain_objects.map do |domain_object|
          mapper_for_domain_object(domain_object).build_dto(domain_object)
        end
      end

      def link_domain_object(domain_object, dto)
        mapper_for_domain_object(domain_object).link_domain_object(domain_object, dto)
      end

      def build_new(dto)
        mapper_for_dto(dto).build_new(dto)
      end

      def build_domain_object(dto)
        mapper_for_dto(dto).build_domain_object(dto)
      end

      def build_domain_objects(dtos)
        dtos.map do |dto|
          mapper_for_dto(dto).build_domain_object(dto)
        end
      end

      protected
        def mapper_for_dto(dto)
          @mappers.find { |mapper| mapper.type_code == dto['type'] }
        end

        def mapper_for_domain_object(role)
          @mappers.find { |mapper| role.kind_of?(mapper.domain_object_class) }
        end
    end
  end
end
