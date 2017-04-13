//
//  FilterTuningBrandCell.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterSelectModel.h"

@interface FilterTuningBrandCell : FJCell

@end

@interface FilterTuningBrandCellDataSource : FJCellDataSource

@property (nonatomic, strong) FilterSelectModel *brand;

@end
