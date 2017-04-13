//
//  FilterTuningSellerCell.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/13.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FilterTuningSellerCell.h"

@interface FilterTuningSellerCell()

@property (nonatomic, weak) IBOutlet UILabel *lb_name;
@property (nonatomic, weak) IBOutlet UIImageView *iv_selected;

@end

@implementation FilterTuningSellerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    __weak typeof(self) weakSelf = self;
    [self.contentView setUserInteractionEnabled:YES];
    [self.contentView bk_whenTapped:^{
        FilterTuningSellerCellDataSource *ds = weakSelf.cellDataSource;
        ds.seller.selected = !ds.seller.selected;
        weakSelf.iv_selected.highlighted = ds.seller.selected;
        weakSelf.delegate == nil ? : [weakSelf.delegate fjcell_actionRespond:ds from:weakSelf];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataSource:(__kindof FJCellDataSource *)cellDataSource {
    [super setCellDataSource:cellDataSource];
    FilterTuningSellerCellDataSource *ds = cellDataSource;
    self.lb_name.text = [ds.seller tag];
    self.iv_selected.highlighted = [ds.seller selected];
}

@end

@implementation FilterTuningSellerCellDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 46.0;
    }
    return self;
}

@end
