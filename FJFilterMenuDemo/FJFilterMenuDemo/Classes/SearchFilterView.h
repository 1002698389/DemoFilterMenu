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

- (void)setupUI;

@property (nonatomic, strong) NSMutableArray<ProductGroup> *group;

- (void)renderGroup:(BOOL)refresh;

@end
