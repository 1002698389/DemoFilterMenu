//
//  FilterPriceCell.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FilterPriceCell.h"

@implementation FilterPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataSource:(__kindof FJCellDataSource *)cellDataSource {
    [super setCellDataSource:cellDataSource];
    FilterPriceCellDataSource *ds = cellDataSource;
    if (ds.allPrice) {
        self.lb_price.text = @"全部";
    }else{
        self.lb_price.text = [NSString stringWithFormat:@"%d - %d",ds.price.lowestPrice, ds.price.highestPrice];
    }
}

@end

@implementation FilterPriceCellDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 46.0;
    }
    return self;
}

@end
