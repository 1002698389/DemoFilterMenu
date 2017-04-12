//
//  SearchFilterCategoryView.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchFilterCategoryView : UIView

@property (nonatomic, copy) void(^categoryTapped)(NSUInteger index, NSString * category);

// 添加Category
- (void)addCategories:(NSArray<NSString *> *)categories;

// 更新是否有勾选项目
- (void)updateSelected:(BOOL)selected;

@end
