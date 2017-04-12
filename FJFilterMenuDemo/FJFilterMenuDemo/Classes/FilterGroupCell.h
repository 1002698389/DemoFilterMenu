//
//  FilterGroupCell.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJTagConfig;

@interface FilterGroupCell : FJCell

@end

@interface FilterGroupCellDataSource: FJCellDataSource

// input
@property (nonatomic, weak) FJTagConfig *tagConfig;
@property (nonatomic, copy) NSString *rootCategory;
@property (nonatomic, copy) NSString *middleCategory;
@property (nonatomic, strong) NSArray<NSString *> *lastCategories;
@property (nonatomic, copy) NSArray<NSString *> *selectedCategories;

// output
@property (nonatomic, copy) NSString *selectedCategory;
@property (nonatomic, assign) BOOL selected;

@end
