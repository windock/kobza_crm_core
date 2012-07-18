module KobzaCRM
  module Domain
    class WebPageAddress
      def initialize(url)
        @url = url
      end

      attr_reader :url
    end
  end
end
