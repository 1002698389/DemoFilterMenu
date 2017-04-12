//
//  FilterGroupHeaderView.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FilterGroupHeaderView.h"

@interface FilterGroupHeaderView()

@property (nonatomic, weak) IBOutlet UILabel     *lb_title;
@property (nonatomic, weak) IBOutlet UIImageView *iv_indicator;

@end

@implementation FilterGroupHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    __weak typeof(self) weakSelf = self;
    [self setUserInteractionEnabled:YES];
    [self bk_whenTapped:^{
        FilterGroupHeaderViewDataSource *ds = weakSelf.headerDataSource;
        weakSelf.delegate == nil ? : [weakSelf.delegate fjheader_actionRespond:ds from:weakSelf];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setHeaderDataSource:(__kindof FJHeaderViewDataSource *)headerDataSource {
    [super setHeaderDataSource:headerDataSource];
    FilterGroupHeaderViewDataSource *ds = headerDataSource;
    self.lb_title.text = ds.secondCategory.length > 0 ? ds.secondCategory : ds.rootCategory;
}

@end

@implementation FilterGroupHeaderViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewHeight = 46.0;
    }
    return self;
}

@end
