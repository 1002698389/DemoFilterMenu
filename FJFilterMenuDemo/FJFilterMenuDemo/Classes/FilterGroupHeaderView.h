//
//  FilterGroupHeaderView.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterGroupHeaderView : FJHeaderView

@end

@interface FilterGroupHeaderViewDataSource : FJHeaderViewDataSource

@property (nonatomic, copy) NSString *rootCategory;
@property (nonatomic, copy) NSString *secondCategory;

@end
