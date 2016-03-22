# LewLogger
日志工具类，支持日志分级，支持 unicode 中文显示，支持 XcodeColors 插件。
若未安装 XcodeColors 插件，也可以通过 emoji 符号区分日志级别。

![安装XcodeColors](https://github.com/pljhonglu/LewBarChart/blob/master/images/has XcodeColors)
![未安装XcodeColors](https://github.com/pljhonglu/LewBarChart/blob/master/images/no XcodeColors)

## 设置日志着色

1. 下载安装 XcodeColors 插件。[下载地址](https://github.com/robbiehanson/XcodeColors)
2. 设置 XcodeColors 参数
	- Xcode 菜单栏 `Product -> Scheme -> Edit Scheme`
	- 选择 `Run -> Arguments`
	- 在 `Environment Variables` 下面点击 `+` 号
	- `Name` 填写 `XcodeColors`，`Value` 填写 `YES`

经过上面设置后，LewLogger 会为不同级别的 Log 自动着色。

## 使用

```objc
[LewLogger setVerbosity:LewLoggerVerbosityBasic];
[LewLogger setDisplayableSeverity:LewLoggerSeverityAll];

LLogError(@"error log");
LLogWarn(@"warn log");
LLogInfo(@"info log");
LLogDebug(@"debug log");
```
## License | 许可

This code is distributed under the terms of the MIT license.
代码使用 MIT license 许可发布.


