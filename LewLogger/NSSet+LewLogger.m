//
//  NSSet+LewLogger.m
//  LewLoggerDemo
//
//  Created by pljhonglu on 16/3/21.
//  Copyright © 2016年 pljhonglu. All rights reserved.
//

#import "NSSet+LewLogger.h"

@implementation NSSet (LewLogger)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];
    
    NSString *tab = @"";
    for (NSUInteger i = 0; i < level; ++i) {
        tab = [tab stringByAppendingString:@"\t"];
    }
    [desc appendString:@"{("];
    for (id obj in self) {
        if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"\n%@\t\"%@\",", tab, obj];
        }else if ([obj isKindOfClass:[NSDictionary class]]
            || [obj isKindOfClass:[NSArray class]]
            || [obj isKindOfClass:[NSSet class]]) {
            NSString *str = [((NSDictionary *)obj) descriptionWithLocale:locale indent:level + 1];
            [desc appendFormat:@"\n%@\t%@,", tab, str];
        }else {
            [desc appendFormat:@"\n%@\t%@,", tab, obj];
        }
    }
    
    if ([desc hasSuffix:@","]) {
        [desc deleteCharactersInRange:NSMakeRange(desc.length-1, 1)];
    }
    
    [desc appendFormat:@"\n%@)}", tab];
    
    return desc.copy;
}

@end
