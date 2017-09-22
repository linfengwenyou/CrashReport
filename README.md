需要配置网络信息，进行日志上送操作。原理：简单封装了`KSCrash`库，满足当前需求即可。

如果需要可以配置上送到指定邮件的情况。

### 使用方法

#### 启动监听

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [LWSCrashReportManager monitorCrashEvents];		// 启动监听
    return YES;
}
```



#### 日志上报

```
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [LWSCrashReportManager uploadCrash];
}
```



#### 添加需要的库

```
SystemConfiguration.framework
MessageUI.framework
libz.tbd
libc++.tbd
```



#### 配置日志上报入口

```
// LWSCrashReportManager.m
+ (void)uploadCrashWithReport:(NSString *)report 
{
  // 配置上传信息
}
```



### 测试注意点

直接连着XCode进行崩溃测试是不会记录的，需要停止XCode运行，单独运行测试机或模拟器，然后再通过XCode运行，这样就可以捕获到刚刚（单独运行测试机或模拟器）的崩溃日志信息。