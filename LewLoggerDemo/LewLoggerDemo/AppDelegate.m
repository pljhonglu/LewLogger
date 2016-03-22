//
//  AppDelegate.m
//  LewLoggerDemo
//
//  Created by pljhonglu on 16/3/22.
//  Copyright © 2016年 pljhonglu. All rights reserved.
//

#import "AppDelegate.h"
#import "LewLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [LewLogger setVerbosity:LewLoggerVerbosityBasic];
    [LewLogger setDisplayableSeverity:LewLoggerSeverityDebug|LewLoggerSeverityInfo|LewLoggerSeverityWarn|LewLoggerSeverityError];
    
    LLogError(@"error log");
    LLogWarn(@"warn log");
    LLogInfo(@"info log");
    LLogDebug(@"debug log");
        
    NSDictionary *dict = @{@"Name"          : @"LewLogger",
                           @"Description"   : @"日志工具类，支持日志分级，支持 unicode 中文显示，支持 XcodeColors 插件。",
                           @"NSSet"         : [NSSet setWithObjects:@(11), @(22) , nil],
                           @"NSArray"       : @[@"value1",
                                                @"value2",
                                                @{@"key1": @{@"key11":@"字典嵌套"}
                                                    }
                                                ],
                           @"NSDictionary"  : @{@"key1" : @"value1",
                                                @"key2": @{@"key21" : @"value21",
                                                           @"key22" : @[@"多层嵌套", @"value222"]
                                                           }
                                                }
                           };
    
    LLogInfo(@"%@", dict);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
