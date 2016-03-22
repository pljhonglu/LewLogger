//
//  LewLogger.m
//  LewLoggerDemo
//
//  Created by pljhonglu on 16/3/21.
//  Copyright © 2016年 pljhonglu. All rights reserved.
//

#import "LewLogger.h"

#ifdef DEBUG
#define LEW_Log(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define LEW_Log(...)
#endif

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define Lew_foregroundColor_error @"fg194,54,33;"
#define Lew_foregroundColor_warn @"fg173,173,39;"
#define Lew_foregroundColor_info @"fg49,231,34;"
#define Lew_foregroundColor_debug @"fg88,51,255;"

static inline void lew_log(LewLoggerSeverity severity, NSString *log){
    if ([LewLogger isEnableXcodeColors]) {
        switch (severity) {
            case LewLoggerSeverityError:{
                LEW_Log((XCODE_COLORS_ESCAPE Lew_foregroundColor_error @"%@" XCODE_COLORS_RESET_FG), log);
                break;
            }
            case LewLoggerSeverityWarn:{
                LEW_Log((XCODE_COLORS_ESCAPE Lew_foregroundColor_warn @"%@" XCODE_COLORS_RESET_FG), log);
                break;
            }
            case LewLoggerSeverityInfo:{
                LEW_Log((XCODE_COLORS_ESCAPE Lew_foregroundColor_info @"%@" XCODE_COLORS_RESET_FG), log);
                break;
            }
            case LewLoggerSeverityDebug:{
                LEW_Log((XCODE_COLORS_ESCAPE Lew_foregroundColor_debug @"%@" XCODE_COLORS_RESET_FG), log);
                break;
            }
            default:
                break;
        }
    }else{
        LEW_Log(@"%@", log);
    }
}

@implementation LewLogger
// date label content
static NSString	*Lew_verbosityFormatPlain	= @"%@ %@ %@";
// date <__FILE__:__LINE__> label content
static NSString	*Lew_verbosityFormatBasic	= @"%@ <%@:%@> %@ %@";
// date <self __FILE__:__LINE__ (_cmd)> label content
static NSString	*Lew_verbosityFormatFull	= @"%@ <%p %@:%@ (%@)> %@ %@";

static LewLoggerVerbosity	Lew_verbosity		= LewLoggerVerbosityBasic;
static LewLoggerSeverity    Lew_displayableSeverity = LewLoggerSeverityDebug|LewLoggerSeverityInfo|LewLoggerSeverityWarn|LewLoggerSeverityError;

+ (void)logWithSeverity:(LewLoggerSeverity)severity
              verbosity:(LewLoggerVerbosity)verbosity
                 object:(id)object
                   file:(char *)file
                   line:(int)line
                    sel:(SEL)sel
                 format:(id)format, ...{
    if (format) {
        va_list args;
        va_start(args, format);
        NSString *logMsg = [[NSString alloc] initWithFormat:format arguments:args];
        [LewLogger logWithSeverity:severity
                         verbosity:verbosity
                            object:object
                              file:file
                              line:line
                               sel:sel
                           content:logMsg];
        va_end(args);
    }
}

+ (void)logWithSeverity:(LewLoggerSeverity)severity
              verbosity:(LewLoggerVerbosity)verbosity
                 object:(id)object
                   file:(char *)file
                   line:(int)line
                    sel:(SEL)sel
                content:(NSString *)content{
    if (!(severity & Lew_displayableSeverity)) {
        return;
    }
    
    NSString *log = [LewLogger Lew_logStringWithSeverity:severity
                                               verbosity:verbosity
                                                  object:object
                                                    file:file
                                                    line:line
                                                     sel:sel
                                                 content:content];
    
    lew_log(severity, log);
}

+ (void)logWithSeverity:(LewLoggerSeverity)severity
                 object:(id)object
                   file:(char *)file
                   line:(int)line
                    sel:(SEL)sel
                content:(NSString *)content{
    [LewLogger logWithSeverity:severity
                     verbosity:Lew_verbosity
                        object:object
                          file:file
                          line:line
                           sel:sel
                       content:content];
}


+ (BOOL)isEnableXcodeColors{
//    setenv("XcodeColors", "YES", 0); // Enables XcodeColors (you obviously have to install it too)
    char *xcode_colors = getenv("XcodeColors");
    if (xcode_colors && (strcmp(xcode_colors, "YES") == 0)){
        // XcodeColors is installed and enabled!
        return YES;
    }
    return NO;
}

#pragma private

+ (NSString *)Lew_logStringWithSeverity:(LewLoggerSeverity)severity
                              verbosity:(LewLoggerVerbosity)verbosity
                                 object:(id)object
                                   file:(char *)file
                                   line:(int)line
                                    sel:(SEL)sel
                                content:(NSString *)content{
    
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    });
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *format = [LewLogger formatForVerbosity:verbosity];
    NSString *label = [LewLogger labelForSeverity:severity];
    
    NSString *filePath = [[NSString stringWithUTF8String:file] lastPathComponent];
    
    switch (verbosity) {
        case LewLoggerVerbosityPlain:{
            NSString *log = [NSString stringWithFormat:format, dateString, label, content];
            return log;
        }
        case LewLoggerVerbosityBasic:{
            NSString *log = [NSString stringWithFormat:format, dateString, filePath, @(line), label, content];
            return log;
        }
        case LewLoggerVerbosityFull:{
            NSString *log = [NSString stringWithFormat:format, dateString, object, filePath, @(line), NSStringFromSelector(sel), label, content];
            return log;
        }
        default:
            return nil;
    }
}

#pragma mark - setter / getter

+ (void)setVerbosity:(LewLoggerVerbosity)verbosity{
    Lew_verbosity = verbosity;
}

+ (LewLoggerVerbosity)verbosity{
    return Lew_verbosity;
}

+ (void)setFormat:(NSString *)format forVerbosity:(LewLoggerVerbosity)verbosity{
    switch (verbosity) {
        case LewLoggerVerbosityBasic:
            Lew_verbosityFormatBasic = format;
            break;
        case LewLoggerVerbosityPlain:
            Lew_verbosityFormatPlain = format;
            break;
        case LewLoggerVerbosityFull:
            Lew_verbosityFormatFull = format;
            break;
        default:
            break;
    }
}

+ (NSString *)formatForVerbosity:(LewLoggerVerbosity)verbosity {
    switch (verbosity) {
        case LewLoggerVerbosityPlain:       return Lew_verbosityFormatPlain;
        case LewLoggerVerbosityBasic:       return Lew_verbosityFormatBasic;
        case LewLoggerVerbosityFull:		return Lew_verbosityFormatFull;
        default:
            return nil;
    }
}

+ (void)setDisplayableSeverity:(LewLoggerSeverity)severity{
    Lew_displayableSeverity = severity;
}

+ (LewLoggerSeverity)displayableSeverity{
    return Lew_displayableSeverity;
}

+ (NSString *)labelForSeverity:(LewLoggerSeverity)severity {
    switch (severity) {
        // 😱👿👻💡🐞❗❌🔴🔵🎃💔💚💛💙
        case LewLoggerSeverityDebug:    return @"[DEBUG💙]";
        case LewLoggerSeverityInfo:     return @"[ INFO💚]";
        case LewLoggerSeverityWarn:     return @"[ WARN💛]";
        case LewLoggerSeverityError:	return @"[ERROR💔]";
        default: return @"";
    }
}
@end
