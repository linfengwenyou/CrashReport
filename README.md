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

