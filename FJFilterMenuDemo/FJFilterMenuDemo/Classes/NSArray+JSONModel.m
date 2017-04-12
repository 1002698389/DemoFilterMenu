//
//  NSArray+JSONModel.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSArray+JSONModel.h"

@implementation NSArray (JSONModel)

- (BOOL)equal:(NSArray<JSONModel*> *)array {
    if (self == nil && array == nil) {
        return YES;
    }else if (self == nil || array == nil) {
        return NO;
    }else{
        if ([self count] == [array count]) {
            for (int i = 0; i < [self count]; i++) {
                if (![[[self objectAtIndex:i] toJSONString] isEqualToString:[[array objectAtIndex:i] toJSONString]]) {
                    return NO;
                }
            }
        }
    }
    return YES;
    
}

@end
