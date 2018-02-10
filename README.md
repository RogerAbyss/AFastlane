# :rocket::rocket:AFastlane自动构建

<!-- [![Travis](https://img.shields.io/travis/RogerAbyss/AFastlane.svg)](https://travis-ci.org/RogerAbyss/AFastlane) -->
<!-- [![Codecov](https://img.shields.io/codecov/c/github/RogerAbyss/AFastlane.svg)](https://codecov.io/gh/RogerAbyss/AFastlane) -->
<img src="https://img.shields.io/badge/support-iOS-brightgreen.svg"> <a href="https://github.com/fastlane/fastlane"><img src="https://img.shields.io/badge/fastlane-Ruby-orange.svg"></a>

[![license](https://img.shields.io/github/license/RogerAbyss/AFastlane.svg)](https://github.com/RogerAbyss/AFastlane/blob/master/LICENSE)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/RogerAbyss/AFastlane.svg)](https://github.com/RogerAbyss/AFastlane)
[![GitHub last commit (branch)](https://img.shields.io/github/last-commit/RogerAbyss/AFastlane.svg)](https://github.com/RogerAbyss/AFastlane)
[![GitHub release](https://img.shields.io/github/release/RogerAbyss/AFastlane.svg)](https://github.com/RogerAbyss/AFastlane)
<br>
<a href="https://github.com/RogerAbyss"><img src="https://img.shields.io/badge/Github-rogerabyss-brightgreen.svg"></a>
<a href="https://gitee.com/rogerabyss"><img src="https://img.shields.io/badge/%E7%A0%81%E4%BA%91-rogerabyss-orange.svg"></a>
<a href="https://www.jianshu.com/u/d8d22723c6a5"><img src="https://img.shields.io/badge/%E7%AE%80%E4%B9%A6-rogerabyss-orange.svg"></a>
<a href="https://www.zhihu.com/people/ren-chao-3-42/activities"><img src="https://img.shields.io/badge/%E7%9F%A5%E4%B9%8E-rogerabyss-blue.svg"></a>
<a href="https://juejin.im/user/594e25186fb9a06bc86e2a7d"><img src="https://img.shields.io/badge/%E6%8E%98%E9%87%91-rogerabyss-blue.svg"></a>

```
AFastlane基于fastlane, 是我们公司自动化持续集成的配置。
解放程序员的时间, 同时也减少了认为修改环境/配置而导致的错误。
具体请参阅最下角的详细文档, 他的功能如下:
```

- [x] 适用于iOS
- [ ] 适用于Android
- [x] 自动构建/自动提升版本号/自动修改项目配置/Pod/Git
- [x] 自动生成项目文档
- [x] 证书管理(不用再下证书, 存什么.p12啥的)
- [x] 邮件通知(漂亮的邮件模板)
- [x] 和Jenkins/TeamCity等系统结合使用
- [x] 较简单的文档

**shell中使用AFastlane**
![cli](/doc/asserts/cli.png)
**TeamCity让运维管理公司项目**
![teamcity](/doc/asserts/teamcity.png)
**项目文档生成**
![jazzy](/doc/asserts/jazzy.png)
**通知邮件给预定的人**
![mail](/doc/asserts/mail.png)

## :rocket: Installation

#### Install Fastlane
```zsh
gem install fastlane
# 还使用到这些
# pod 包管理
gem install cocoapods
# 上传fir.im
gem install fir-cli
# 发送邮件
gem install mail
# 生成文档Objective-C/Swift
gem install jazzy
```

[Fastlane官方文档](https://docs.fastlane.tools/actions/)

#### 1.Import AFastlane

在项目根目录初始化fastlane
```zsh
# 初始化
fastlane init
```
修改Fastfile如下
```ruby
# Fastfile 
# Copyright@2017 Abyss

fastlane_version "2.69.2"
default_platform :ios

platform :ios do

	before_all do
	end

    # 引用0.0.4
	import_from_git(
		url: 'git@github.com:RogerAbyss/AFastlane.git', 
		branch: '0.0.4',
		path: 'fastlane/IOSAppFastfile'
	  )

	after_all do
	end
end
```

#### 2.Usage

action | description | function
-|:-:|-:
fastlane test|构建测试版|上传fir.im,configuration=debug
fastlane beta|构建预发版|上传fir.im,configuration=release
fastlane release|构建正式服|上传appstore,configuration=release
fastlane setting|申请证书|需要删除原有所有证书
fastlane decices|注册Devices|需要添加到证书需要手动
fastlane refersh|获取证书|申请只需要一次, 其他人获取更新
fastlane change|改变项目配置|根据环境, 提升版本号/修改App bundle ID等信息
fastlane ...|很多|参考[官方文档](https://docs.fastlane.tools/actions/)

 ```zsh
 # 额外需要注意的是, 为了cli的方便我们需要提前配置以下文件:
 .env # 环境变量, AFastlane
 Appfile # 描述App信息, 官方
 Gymfile # 编译配置, 官方
 Matchfile # 证书匹配配置, 官方
 Emailfile # 邮件发送配置, AFastlane
 devices.txt # 新增设备, 参考苹果开发者中心设备导入格式

 # 以上, 请在详细文档中查看实例, 和使用方法。
 # 如果是官方可以, 参考官方文档
 ```

#### 3.Bundler 

有关``bundle exec fastlane``, 新增文件``Gemfile``如下,
```ruby
# frozen_string_literal: true
source "https://gems.ruby-china.org"

gem "mail"
gem "fir-cli"
gem "fastlane"
gem "cocoapods"
gem "jazzy"
```

#### 4.Jazzy 文档生成

有关文档生成, 请完成以下配置, 更多参考[Jazzy官方文档]()
```zsh
jazzy.yaml # Jazzy环境配置

jazzy -config jazzy.yaml # 开始生成文档
```
#### 5.Teamcity

暂时省略
[TeamCity](https://www.jetbrains.com/zh/teamcity/specials/teamcity/teamcity.html?utm_source=baidu&utm_medium=cpc&utm_campaign=cn-bai-br-teamcity-ex-pc&utm_content=teamcity-pure&utm_term=teamcity)

## :fire: Star me

* AFstlane详细文档
* Git项目管理美化版

**如果对你有所帮助, 欢迎Star我。**

## :construction_worker: Author

roger_ren@qq.com

## :globe_with_meridians: License

AFastlane is available under the MIT license. See the LICENSE file for more info.
