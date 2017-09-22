//
//  LWSCrashReportManager.m
//  ReportDemo
//
//  Created by LIUSONG on 2017/9/22.
//  Copyright © 2017年 ucsmy. All rights reserved.
//

#import "LWSCrashReportManager.h"
#import "KSCrashInstallationConsole.h"
#import "KSCrash.h"

@interface LWSCrashReportManager()
@property (nonatomic, strong) KSCrashInstallation *crashInstallation;

+ (instancetype)sharedManager;


@end
@implementation LWSCrashReportManager

#pragma mark - 开放方法
+ (instancetype)sharedManager
{
    static LWSCrashReportManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

+ (void)monitorCrashEvents
{
    [[self sharedManager] configCrashInstallation];
}

+ (void)uploadCrash
{
    // 在这里可以配置
    [[self sharedManager] handleCrashWithBlock:^(NSArray<NSString *> *reports) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (reports) {
                for (NSString *report in reports) {
                    if (report.length > 0) {
                        [self uploadCrashWithReport:report];
                    }
                }
            }
        });
    }];
}


+ (void)uploadCrashWithReport:(NSString *)report
{
#warning liu 需要配置网络上送
    NSLog(@"崩溃信息：%@",report);
    /*
     // 网络请求等操作
     */
    // 成功后需要移除之前的日志信息
//    [[KSCrash sharedInstance] deleteAllReports];
    
}

#pragma mark - 实例方法
- (void)configCrashInstallation
{
    [KSCrash sharedInstance].deleteBehaviorAfterSendAll = KSCDeleteNever;
    KSCrashInstallationConsole *consoleInstallation = [KSCrashInstallationConsole sharedInstance];
    consoleInstallation.printAppleFormat = YES; // 使用苹果的日志格式，默认为NO
    
    self.crashInstallation = consoleInstallation;
    [self.crashInstallation install];
}

- (void)handleCrashWithBlock:(void(^)(NSArray <NSString *> *reports))block
{
    [self.crashInstallation sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error) {
        if (completed) {
            NSArray *crashReports = [filteredReports copy];
            if (block) {
                block(crashReports);
            }
        }
    }];
    
}

@end
