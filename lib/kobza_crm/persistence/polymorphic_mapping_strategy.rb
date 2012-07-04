module KobzaCRM
  module Persistence
    class PolymorphicMappingStrategy
      def initialize(strategies)
        @strategies = strategies
      end

      def build_dto(domain_object)
        strategy_for_domain_object(domain_object).build_dto(domain_object)
      end

      def build_dtos(domain_objects)
        domain_objects.map do |domain_object|
          strategy_for_domain_object(domain_object).build_dto(domain_object)
        end
      end

      def link_domain_object(domain_object, dto)
        strategy_for_domain_object(domain_object).link_domain_object(domain_object, dto)
      end

      def build_new(dto)
        strategy_for_dto(dto).build_new(dto)
      end

      def build_domain_object(dto)
        strategy_for_dto(dto).build_domain_object(dto)
      end

      def build_domain_objects(dtos)
        dtos.map do |dto|
          strategy_for_dto(dto).build_domain_object(dto)
        end
      end

      protected
        def strategy_for_dto(dto)
          strategies.find { |strategy| strategy.type_code == dto['type'] }
        end

        def strategy_for_domain_object(role)
          strategies.find { |strategy| role.kind_of?(strategy.domain_object_class) }
        end

      private
        attr_reader :strategies
    end
  end
end
