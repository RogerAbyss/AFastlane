require 'rubygems'
require 'mail' 
require 'erb'

module Fastlane
  module Actions
    class EmailAction < Action

      def self.run(params)
        version   = params[:version]
        commitMsg = params[:commitmsg]|| ""

        lane      = Actions.lane_context[SharedValues::LANE_NAME].to_s

        params.load_configuration_file("Emailfile")
        sender    = params[:sender]
        reciver   = params[:reciver]
        token     = params[:token]
        manager   = params[:manager]
        title     = params[:title]    || "App-#{lane}"
        content   = params[:content]  || "这是一个自动构建的App"
        action    = params[:action]   || "关注我"
        actionurl = params[:actionurl]|| "http://rogerabyss.github.io"
        code      = params[:code]     || ""

        UI.message("开始发送邮件...")
        UI.message("\n发件人:#{sender}\n收件人:#{reciver}\n邮件标题:#{title}\n邮件内容:#{content}")

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

        email_title =  "🚀App[" + title + "]v" + version + " 更新了!"
        @erb_theme = email_title
        @erb_title = email_title
        @erb_content = content + "/n/n"  + commitMsg
        @erb_action = action
        @erb_action_url = actionurl
        @erb_code = code

        file = File.read("email.erb.html")
        out = ERB.new(file)

        mail = Mail.new do
          charset = "UTF-8"
          from sender
          to manager
          cc reciver
          subject email_title
        end

        mail.html_part = out.result(binding)
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
          key: :action,
          env_name: "EMAIL_ACTION",
          description: "email_action",
          type: String,
          optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :actionurl,
            env_name: "EMAIL_ACTIONURL",
            description: "email_actionurl",
            type: String,
            optional: true,
          ),
          FastlaneCore::ConfigItem.new(
            key: :version,
            env_name: "EMAIL_VERSION",
            description: "email_version",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :commitmsg,
            env_name: "EMAIL_COMMITMSG",
            description: "email_commitmsg",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :manager,
            env_name: "EMAIL_MANAGER",
            description: "email_manager",
            type: String,
            optional: false,
          ),
          FastlaneCore::ConfigItem.new(
            key: :code,
            env_name: "EMAIL_CODE",
            description: "email_code",
            type: String,
            optional: true,
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