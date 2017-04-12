//
//  SearchFilterView.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/11.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSearchResponse.h"

@interface SearchFilterView : UIView

@property (nonatomic, strong) NSMutableArray<ProductGroup> *group;

@property (nonatomic, copy) void(^filterSelectedTuning)(id data);

- (void)setupUI;

- (void)renderGroup:(BOOL)refresh;

@end
