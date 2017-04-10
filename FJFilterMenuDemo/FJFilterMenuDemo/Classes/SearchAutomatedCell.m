//
//  SearchAutomatedCell.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchAutomatedCell.h"
#import <BlocksKit/BlocksKit+UIKit.h>
#import <FJTool/FJTool.h>

@interface SearchAutomatedCell()

@property (nonatomic, weak) IBOutlet UILabel *lb_title;

@end

@implementation SearchAutomatedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    MF_WEAK_SELF(self);
    [self.contentView bk_whenTapped:^{
        SearchAutomatedCellDataSource *ds = weakSelf.cellDataSource;
        weakSelf.delegate == nil ? : [weakSelf.delegate fjcell_actionRespond:ds from:weakSelf];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataSource:(__kindof FJCellDataSource *)cellDataSource {
    [super setCellDataSource:cellDataSource];
    SearchAutomatedCellDataSource *ds = cellDataSource;
    self.lb_title.text = ds.key;
}

@end

@implementation SearchAutomatedCellDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 44.0;
    }
    return self;
}

@end
