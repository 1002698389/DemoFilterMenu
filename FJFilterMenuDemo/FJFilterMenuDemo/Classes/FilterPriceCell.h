//
//  FilterPriceCell.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterSelectModel.h"

@interface FilterPriceCell : FJCell
@property (nonatomic, weak) IBOutlet UILabel *lb_price;

@end


@interface FilterPriceCellDataSource : FJCellDataSource

@property (nonatomic, assign) BOOL allPrice;
@property (nonatomic, strong) FilterSelectModel *price;

@end
