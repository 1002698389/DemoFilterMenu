//
//  NSArray+JSONModel.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSONModel)

- (BOOL)equal:(NSArray<JSONModel*> *)array;

@end
