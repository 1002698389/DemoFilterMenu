//
//  SearchFilterView.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/11.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSearchResponse.h"
#import "FilterSelectModel.h"

@interface SearchFilterView : UIView

@property (nonatomic, strong) NSMutableArray<ProductGroup> *group;

@property (nonatomic, copy) void(^filterSelectedTuning)(NSMutableArray<FilterSelectModel *> *catergory, NSMutableArray<FilterSelectModel *> *brand, NSMutableArray<FilterSelectModel *> *seller, FilterSelectModel *price);

// 初始化UI
- (void)setupUI;

// 加载Category
- (void)renderGroup:(BOOL)refresh;

// 加载品牌、商家、价格
- (void)renderTuning:(BOOL)refresh inloading:(BOOL)inloading;

@end
