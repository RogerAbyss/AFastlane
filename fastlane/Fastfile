# Fastfile 
# Copyright@2017 Abyss

fastlane_version "2.69.2"
default_platform :ios

platform :ios do

	before_all do
	end

	desc '测试版'
	lane :dev do |options|
	end


	# 测试版本
	import "subFastfile/TestFastfile"
	# 预发布版本
	import "subFastfile/BetaFastfile"
	# 正式版本
	import "subFastfile/ReleaseFastfile"
	# 工具
	import "subFastfile/ToolFastfile"
	# 私有方法
	import "subFastfile/PrivateFastfile"
	# 私有方法
	import "subFastfile/AutotestFastfile"

	after_all do
	end
end