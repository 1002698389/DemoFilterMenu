//
//  FilterGroupCell.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FilterGroupCell.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"
#import "NSArray+FJTagModel.h"

@interface FilterGroupCell()

@property (nonatomic, strong) FJTagCollectionView *tagView;

@end

@implementation FilterGroupCell

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
    
    FilterGroupCellDataSource *ds = cellDataSource;
    [self.tagView removeAllTags];
    [self.tagView addTags:ds.lastCategories config:ds.tagConfig selectedTags:ds.selectedCategories];
    [self.tagView refresh];
}

- (FJTagCollectionView *)tagView {
    if (_tagView == nil) {
        _tagView = [[FJTagCollectionView alloc] init];
        [_tagView setTagViewOrigin:CGPointMake(0, 0)];
        [self addSubview:_tagView];
        [_tagView setTagViewWidth:UI_SCREEN_WIDTH - 100.0];
        __weak typeof(self) weakSelf = self;
        _tagView.tagMultiTappedBlock = ^(__kindof FJTagModel *tag, BOOL selected) {
            FilterGroupCellDataSource *ds = weakSelf.cellDataSource;
            ds.selectedCategory = tag;
            ds.selected = selected;
            weakSelf.delegate == nil ? : [weakSelf.delegate fjcell_actionRespond:ds from:weakSelf];
        };
    }
    return _tagView;
}

@end

@implementation FilterGroupCellDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
