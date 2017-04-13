//
//  RecentSearchModel.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJTagModel.h"

@interface RecentSearchModel : JSONModel

@property (nonatomic, strong) NSMutableArray<FJTagModel, Optional> *history;

@end
