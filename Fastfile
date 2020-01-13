# This file contains the fastlane.tools configuration
# You can find the documentation at https://docs.fastlane.tools
#
# For a list of all available actions, check out
#
#     https://docs.fastlane.tools/actions
#
# For a list of all available plugins, check out
#
#     https://docs.fastlane.tools/plugins/available-plugins
#

# Uncomment the line if you want fastlane to automatically update itself
# update_fastlane

fastlane_version("2.127.2")
default_platform(:ios)

platform :ios do

  desc "自动化构建ios"
  lane :start do |options|

    config = options[:config]

    # 确保分支最新
    # git_pull
    # 确保分支干净
    # ensure_git_status_clean

    # 获取configuration
    # if config == nil
    #   config = UI.select("what configuration do you want to run: ",
    #      ["Debug", "Adhoc", "Enterprise", "AppStore"])
    # end

    clean_for_preare
    prepare_for_build
    build_for_app
    app_for_upload
    app_for_analysis
    git_for_commit

  end

  private_lane :prepare_for_build do |options|
    # 更改App名字
    # 此方法并没有成功修改 PRODUCT_BUNDLE_IDENTIFIER 
    # Warning - 用此方法修改app_identifier, 反而导致PRODUCT_BUNDLE_IDENTIFIER错乱无法成功匹配
    path = ENV["AFASTLANE_NAME"]
    
    # 更改显示名字
    update_info_plist(
      plist_path: "#{path}/Core/Info.plist",
      display_name: ENV["AFASTLANE_APP_NAME"],
    )
  
    # 更改identifier
    update_app_identifier(
      plist_path: "#{path}/Core/Info.plist",
      app_identifier: ENV["AFASTLANE_IDENTIFIER"],
    )

    version = increment_version_number()
    increment_build_number(
      build_number: version,
      xcodeproj: "#{ENV["AFASTLANE_NAME"]}.xcodeproj"
      )
  end

  private_lane :build_for_app do |options|

    version = get_version_number(
      xcodeproj: ENV["APP_PROJECT"],
      target: ENV["AFASTLANE_NAME"],
    )

    # 从仓库匹配证书
    match(type: ENV["AFSTLANE_GYM_MATCH"])

    # 设置team
    update_project_team(
      path: "#{ENV["AFASTLANE_NAME"]}.xcodeproj",
      teamid: "#{ENV["AFASTLANE_TEAMID"]}"
    )

    # 构建
    build_ios_app(
      output_name: "#{ENV["AFASTLANE_NAME"]}-#{version}.ipa"
    )
  end

  private_lane :app_for_upload do |options|
    config = ENV["AFSTLANE_GYM_MATCH"]

    # 测试上传的二进制文件
    # lane_context[SharedValues::IPA_OUTPUT_PATH] = "/Users/abyss/Desktop/Strawberry-iOS/Strawberry/build/sale/Strawberry-1.0.149.ipa"

    if config == "appstore"
      # DAV
      # Signiant
      # Aspera
      ENV["DELIVER_ITMSTRANSPORTER_ADDITIONAL_UPLOAD_PARAMETERS"] = "-t Aspera"
      deliver()
    else 
      # 上传蒲公英
      api_key = ENV["AFASTLANE_PYGER_APIKEY"]
      user_key = ENV["AFASTLANE_PYGER_UKEY"]
      pwd = ENV["AFASTLANE_PYGER_PWD"]

      if api_key.to_s.length > 0 
        sh("curl",
          "-F","file=@#{lane_context[SharedValues::IPA_OUTPUT_PATH]}",
          "-F","uKey=#{ENV["AFASTLANE_PYGER_UKEY"]}",
          "-F","_api_key=#{ENV["AFASTLANE_PYGER_APIKEY"]}",
          "-F","updateDescription=#{ENV["AFASTLANE_PYGER_INFO"]}",
          "-F","installType=2",
          "-F","password=123",
          "https://www.pgyer.com/apiv1/app/upload"
        )

        # 获取版本号
        version = version = get_version_number(
          xcodeproj: ENV["APP_PROJECT"],
          target: ENV["AFASTLANE_NAME"],
        )
        UI.important "#{version}"
        # 发送邮件
        email(version: version)
      end
    end
  end

  private_lane :clean_for_preare do |options|
    # 如果是自动化, 需要清理缓存
    if is_ci
      UI.message("清理CI缓存文件")
      sh("rm","-rf","../build")
      sh("rm","-rf","logs")
      else
    end
  end

  private_lane :app_for_analysis do |options|
    UI.message("执行分析")
    sh("sh","analysis.sh")
  end

  private_lane :git_for_commit do |options|
    version = get_version_number(
      xcodeproj: "#{ENV["AFASTLANE_NAME"]}.xcodeproj",
      target: ENV["AFASTLANE_NAME"])

    build = get_build_number(xcodeproj: "#{ENV["AFASTLANE_NAME"]}.xcodeproj")

    git_add(path: '.')
		git_commit(path: '.', message: "🚀 自动打包 [#{ENV["AFSTLANE_GYM_CONFIG"]}] - v#{version}(#{build})")
  end
end