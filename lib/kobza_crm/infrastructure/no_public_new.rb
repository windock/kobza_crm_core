module KobzaCRM module Infrastructure
  module NoPublicNew
    module ClassMethods
      def instance(*args)
        new(*args)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
      base.private_class_method(:new)
    end
  end
end end
