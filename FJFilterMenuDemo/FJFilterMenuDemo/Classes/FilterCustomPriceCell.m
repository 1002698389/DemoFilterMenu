//
//  FilterCustomPriceCell.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FilterCustomPriceCell.h"

@interface FilterCustomPriceCell()

@property (nonatomic, weak) IBOutlet UITextField *tf_lowest;
@property (nonatomic, weak) IBOutlet UITextField *tf_highest;

@end

@implementation FilterCustomPriceCell

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
}

@end

@implementation FilterCustomPriceCellDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 100.0;
    }
    return self;
}

@end
