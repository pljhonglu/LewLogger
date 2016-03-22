//
//  NSDictionary+LewLogger.m
//  LewLoggerDemo
//
//  Created by pljhonglu on 16/3/21.
//  Copyright © 2016年 pljhonglu. All rights reserved.
//

#import "NSDictionary+LewLogger.h"

@implementation NSDictionary (LewLogger)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *desc = [NSMutableString string];

    NSString *tab = @"";
    for (NSUInteger i = 0; i < level; ++i) {
        tab = [tab stringByAppendingString:@"\t"];
    }
    [desc appendString:@"{"];
    
    for (id key in self.allKeys) {
        id obj = [self objectForKey:key];
        
        if ([obj isKindOfClass:[NSString class]]) {
            [desc appendFormat:@"\n%@\t%@ = \"%@\",", tab, key, obj];
        } else if ([obj isKindOfClass:[NSArray class]]
                   || [obj isKindOfClass:[NSDictionary class]]
                   || [obj isKindOfClass:[NSSet class]]) {
            [desc appendFormat:@"\n%@\t%@ = %@,", tab, key, [obj descriptionWithLocale:locale indent:level + 1]];
        }else {
            [desc appendFormat:@"\n%@\t%@ = %@,", tab, key, obj];
        }
    }
    if ([desc hasSuffix:@","]) {
        [desc deleteCharactersInRange:NSMakeRange(desc.length-1, 1)];
    }
    [desc appendFormat:@"\n%@}", tab];
    return desc.copy;
}

@end
