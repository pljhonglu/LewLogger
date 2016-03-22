//
//  LewLogger.h
//  LewLoggerDemo
//
//  Created by pljhonglu on 16/3/21.
//  Copyright © 2016年 pljhonglu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_OPTIONS(NSUInteger, LewLoggerSeverity) {
    LewLoggerSeverityDebug = 1 << 0,
    LewLoggerSeverityInfo = 1 << 1,
    LewLoggerSeverityWarn = 1 << 2,
    LewLoggerSeverityError = 1 << 3,
    
    LewLoggerSeverityAll = LewLoggerSeverityDebug|LewLoggerSeverityInfo|LewLoggerSeverityWarn|LewLoggerSeverityError,
};

typedef NS_ENUM(NSUInteger, LewLoggerVerbosity) {
    LewLoggerVerbosityPlain,
    LewLoggerVerbosityBasic,
    LewLoggerVerbosityFull
};

#if DEBUG

#define LLogNSError(error) {if(err) LLogError(@"%@", error)}

#define LLogError(format, ...) LSLog(LewLoggerSeverityError, format, ##__VA_ARGS__)
#define LLogWarn(format, ...) LSLog(LewLoggerSeverityWarn, format, ##__VA_ARGS__)
#define LLogInfo(format, ...) LSLog(LewLoggerSeverityInfo, format, ##__VA_ARGS__)
#define LLogDebug(format, ...) LSLog(LewLoggerSeverityDebug, format, ##__VA_ARGS__)

#define LSLog(severity, format, ...) [LewLogger logWithSeverity:severity object:self file:__FILE__ line:__LINE__ sel:_cmd content:[NSString stringWithFormat:(format), ##__VA_ARGS__]]

#define LSVLog(severity, verbosity, format, ...) [LewLogger logWithSeverity:severity verbosity:verbosity object:self file:__FILE__ line:__LINE__ sel:_cmd content:[NSString stringWithFormat:(format), ##__VA_ARGS__]]

#else

#define LLogNSError(error)

#define LLogError(format, ...)
#define LLogWarn(format, ...)
#define LLogInfo(format, ...)
#define LLogDebug(format, ...)

#define LSLog(severity, format, ...)
#define LSVLog(severity, verbosity, format, ...)

#endif

@interface LewLogger : NSObject

+ (void)logWithSeverity:(LewLoggerSeverity)severity
              verbosity:(LewLoggerVerbosity)verbosity
                 object:(id)object
                   file:(char *)file
                   line:(int)line
                    sel:(SEL)sel
                 format:(NSString *)format, ...;

+ (void)logWithSeverity:(LewLoggerSeverity)severity
              verbosity:(LewLoggerVerbosity)verbosity
                 object:(id)object
                   file:(char *)file
                   line:(int)line
                    sel:(SEL)sel
                content:(NSString *)content;

+ (void)logWithSeverity:(LewLoggerSeverity)severity
                 object:(id)object
                   file:(char *)file
                   line:(int)line
                    sel:(SEL)sel
                content:(NSString *)content;

// default is LewLoggerVerbosityBasic
+ (void)setVerbosity:(LewLoggerVerbosity)verbosity;
+ (LewLoggerVerbosity)verbosity;
+ (NSString *)formatForVerbosity:(LewLoggerVerbosity)verbosity;
+ (void)setFormat:(NSString *)format
     forVerbosity:(LewLoggerVerbosity)verbosity;

// default is LewLoggerSeverityDebug
+ (void)setDisplayableSeverity:(LewLoggerSeverity)severity;
+ (LewLoggerSeverity)displayableSeverity;

+ (BOOL)isEnableXcodeColors;
@end
