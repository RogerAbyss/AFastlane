require 'rubygems'
require 'mail' 

module Fastlane
  module Actions
    class EmailAction < Action

      def self.run(params)
        lane      = Actions.lane_context[SharedValues::LANE_NAME].to_s

        params.load_configuration_file("Emailfile")
        sender    = params[:sender]
        reciver   = params[:reciver]
        token     = params[:token]
        manager   = params[:manager]
        title     = params[:title]    || "App-#{lane}"
        content   = params[:content]  || "这是一个自动构建的App"

        UI.current.log.info "开始发送邮件...".green
        UI.current.log.info "\n发件人:#{sender}\n收件人:#{reciver}\n邮件标题:#{title}\n邮件内容:#{content}".green

        # 打印git记录
        Actions.sh "git log --graph  --abbrev-commit --pretty=format:'%s    - %an(%cr)' -30 >report-git.txt"
        file = File.read("report-git.txt")

        smtp = {
          :address => 'smtp.qq.com', 
          :port => 25, 
          :domain => 'qq.com', 
          :user_name => sender, 
          :password => token,
          :enable_starttls_auto => true,
          :openssl_verify_mode => 'none', 
        }

        Mail.defaults { delivery_method :smtp, smtp}

        mail = Mail.new do
          charset = "UTF-8"
          from sender
          to manager
          cc reciver
          subject title
          body content + '\n\n☞此页面提供更多帮助: 
      https://github.com/RogerAbyss/Ascript/tree/master/build/info

      ☞以下为近期提交记录:' + file
        end

        mail.charset = 'UTF-8'
        mail.content_transfer_encoding = '8bit'
        mail.deliver!

      end


      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
          key: :sender,
          env_name: "EMAIL_SENDER",
          description: "email_sender",
          type: String,
          optional: false
          ),
          FastlaneCore::ConfigItem.new(
          key: :reciver,
          env_name: "EMAIL_RECIVER",
          description: "email_riciver",
          type: Array,
          optional: false
          ),
          FastlaneCore::ConfigItem.new(
          key: :token,
          env_name: "EMAIL_TOKEN",
          description: "email_sender",
          type: String,
          optional: false
          ),
          FastlaneCore::ConfigItem.new(
          key: :title,
          env_name: "EMAIL_TITLE",
          description: "email_title",
          type: String,
          optional: true,
          ),
          FastlaneCore::ConfigItem.new(
          key: :content,
          env_name: "EMAIL_CONTENT",
          description: "email_content",
          type: String,
          optional: true,
          ),
          FastlaneCore::ConfigItem.new(
          key: :manager,
          env_name: "EMAIL_MANAGER",
          description: "email_manager",
          type: String,
          optional: false,
          ),
        ]
      end

      def self.return_value
      end

      def self.description
        "send qq email easier"
      end

      def self.details
        "send qq email easier"
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