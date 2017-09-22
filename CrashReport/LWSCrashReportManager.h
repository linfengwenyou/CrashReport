//
//  LWSCrashReportManager.h
//  ReportDemo
//
//  Created by LIUSONG on 2017/9/22.
//  Copyright © 2017年 ucsmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWSCrashReportManager : NSObject

/**
 监测崩溃事件
 */
+ (void)monitorCrashEvents;

/**
 上送崩溃日志，需要在方法内部配置网络请求
 */
+ (void)uploadCrash;

/**
 使用注意：在AppDelegate中调用
 1. 在didFinishLaunchingWithOptions 中调用监听方法
   [LWSCrashReportManager monitorCrashEvents];
 
 2. 在程序进入活跃状态中进行日志上传处理
   [LWSCrashReportManager uploadCrash];
 
 3. 需要在uploadCrash内部配置网络信息
 */

@end
