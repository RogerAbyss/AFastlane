module Fastlane
  module Actions
    class PodUpdateAction < Action
      def self.run(params)
      	Actions.sh "pod install --no-repo-update --verbose"
        UI.current.log.info "国内速度太慢，使用--no-repo-update节约大量的时间 ⬆️ ".green
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Update all pods"
      end

      def self.details
        "Update all pods"
      end

      def self.authors
        ["abyss"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
