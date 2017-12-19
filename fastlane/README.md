fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

## Choose your installation method:

<table width="100%" >
<tr>
<th width="33%"><a href="http://brew.sh">Homebrew</a></th>
<th width="33%">Installer Script</th>
<th width="33%">RubyGems</th>
</tr>
<tr>
<td width="33%" align="center">macOS</td>
<td width="33%" align="center">macOS</td>
<td width="33%" align="center">macOS or Linux with Ruby 2.0.0 or above</td>
</tr>
<tr>
<td width="33%"><code>brew cask install fastlane</code></td>
<td width="33%"><a href="https://download.fastlane.tools">Download the zip file</a>. Then double click on the <code>install</code> script (or run it in a terminal window).</td>
<td width="33%"><code>sudo gem install fastlane -NV</code></td>
</tr>
</table>

# Available Actions
## iOS
### ios dev
```
fastlane ios dev
```
测试版
### ios test
```
fastlane ios test
```
测试版,上传Fir
### ios beta
```
fastlane ios beta
```
预发布版(测试正式环境),上传Fir
### ios release
```
fastlane ios release
```
正式服(使用前请自行处理好所有的git事务, 选择发布的分支), 上传AppStore
### ios refresh
```
fastlane ios refresh
```
刷新证书, 如果失败请于管理员联系
### ios setting
```
fastlane ios setting
```
设置证书(非管理员, 请不要使用此功能)
### ios clear_cache
```
fastlane ios clear_cache
```
清理打包缓存
### ios func
```
fastlane ios func
```
功能列表
### ios auto_test
```
fastlane ios auto_test
```
自动化测试
### ios lib_lint
```
fastlane ios lib_lint
```
lib lint
### ios lib_push
```
fastlane ios lib_push
```
lib push

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
