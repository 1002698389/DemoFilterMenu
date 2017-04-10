//
//  SearchAutomatedView.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchAutomatedView.h"
#import <Masonry/Masonry.h>
#import <FJTableView/FJTableViewHeader.h>
#import <FJTool/FJTool.h>
#import "SearchAutomatedCell.h"

@interface SearchAutomatedView()

@property (nonatomic, strong) SolidLine *line;
@property (nonatomic, strong) FJTableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation SearchAutomatedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (SolidLine *)line {
    if (_line == nil) {
        _line = [SolidLine line:CGRectMake(0, 0, UI_SCREEN_WIDTH, 1.0) orient:LineOrient_RectUp color:COLOR_GRAY_999999];
        [self addSubview:_line];
        MF_WEAK_SELF(self);
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf);
            make.height.equalTo(@1.0);
        }];
    }
    return _line;
}

- (FJTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [FJTableView FJTableView:self.bounds editStyle:0 seperatorStyle:0 bgColor:[UIColor whiteColor]];
        [self addSubview:_tableView];
        MF_WEAK_SELF(self);
        __weak SolidLine *weakLine = self.line;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakLine.mas_bottom);
            make.left.right.bottom.equalTo(weakSelf);
        }];
        
        // 设置Cell Action Block
        [_tableView setCellActionBlock:^(FJ_CellBlockType type, NSInteger row, NSInteger section, __kindof FJCellDataSource *cellData) {
            if (type == FJ_CellBlockType_CellCustomizedTapped) {
                SearchAutomatedCellDataSource *ds = cellData;
                weakSelf.tagTapped == nil ? : weakSelf.tagTapped(ds.key);
            }
        }];
        
        // 设置Cell Scroll Block
        [_tableView setCellScrollBlock:^(FJ_ScrollBlockType type, UIScrollView *scrollView, CGFloat height, BOOL willDecelerate) {
            if (type == FJ_ScrollBlockType_Scroll) {
                weakSelf.tagScrolled == nil ? : weakSelf.tagScrolled();
            }
        }];
    }
    return _tableView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
        MF_WEAK_SELF(self);
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
    }
    return _indicatorView;
}

- (void)refresh:(NSString*)keyword {
    
    self.line.hidden = NO;
    self.tableView.hidden = NO;
    MF_WEAK_SELF(self);
    
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indicatorView.hidden = YES;
        
        [[weakSelf.tableView dataSource] removeAllObjects];
        
        NSArray *automated = @[@"11",@"22",@"33",@"44",@"55",@"66",@"77",@"88",@"99",@"00",@"11",@"22",@"33",@"44",@"55",@"66",@"77",@"88",@"99",@"00"];
        for (NSString *key in automated) {
            SearchAutomatedCellDataSource *ads = [[SearchAutomatedCellDataSource alloc] init];
            ads.key = [NSString stringWithFormat:@"%@_%@",keyword , key];
            [weakSelf.tableView addDataSource:ads];
        }
        [weakSelf.tableView refresh];
        
    });
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
