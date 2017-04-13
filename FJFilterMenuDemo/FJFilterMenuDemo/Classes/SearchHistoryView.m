//
//  SearchHistoryView.m
//  FJFilterMenuDemo
//

#import "SearchHistoryView.h"
#import "SearchHistoryCell.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"
#import "RecentSearchModel.h"
#import "HotSearchModel.h"

@interface SearchHistoryView()

@property (nonatomic, strong) SolidLine *line;
@property (nonatomic, strong) FJTableView *tableView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation SearchHistoryView

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
                SearchHistoryCellDataSource *ds = cellData;
                switch (ds.action) {
                    case TagAction_Deletion:
                    {
                        if ([FJStorage isExistKey:@"RecentSearch"]) {
                            [FJStorage clearObject:@"RecentSearch"];
                            [weakSelf refresh:NO];
                        }
                        break;
                    }
                    case TagAction_Tapped:
                    {
                        weakSelf.tagTapped == nil ? : weakSelf.tagTapped(ds.tag);
                        break;
                    }
                }
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        HotSearchModel *hotSearchModel = [[HotSearchModel alloc] init];
        hotSearchModel.data = (NSMutableArray<FJTagModel> *)[[NSMutableArray alloc] init];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"阿迪达斯"]];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"Michael Koros"]];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"手表"]];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"Swarovski"]];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"Armani"]];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"自行车"]];
        [hotSearchModel.data addObject:[FJTagModel tagName:@"Ashford"]];
        [FJStorage save_jsonmodel:hotSearchModel key:@"HotSearch"];
    }
    return self;
}

- (void)refresh:(BOOL)hotSearch {
    
    self.line.hidden = NO;
    if (hotSearch) {
        
        self.tableView.hidden = YES;
        
        // Clear Cell
        [[self.tableView dataSource] removeAllObjects];
        
        self.indicatorView.hidden = NO;
        [self.indicatorView startAnimating];
        
        // Recent Search History
        RecentSearchModel *recentSearchModel = [FJStorage value_jsonmodel:@"RecentSearchModel" key:@"RecentSearch"];
        // Add Cell
        self.tableView.hidden = NO;
        SearchHistoryCellDataSource *sds = [[SearchHistoryCellDataSource alloc] init];
        CGSize size = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH tags:recentSearchModel.history config:[FJTagConfig new]];
        sds.cellHeight = size.height + 30.0;
        sds.title = @"最近搜索";
        sds.tags = recentSearchModel.history;
        [self.tableView addDataSource:sds];
        [self.tableView refresh];
        
        MF_WEAK_SELF(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.indicatorView stopAnimating];
            weakSelf.indicatorView.hidden = YES;
            
            // Hot Search
            HotSearchModel *hotSearchModel = [FJStorage value_jsonmodel:@"HotSearchModel" key:@"HotSearch"];
            // Add Cell
            SearchHistoryCellDataSource *hds = [[SearchHistoryCellDataSource alloc] init];
            CGSize size = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH tags:hotSearchModel.data config:[FJTagConfig new]];
            hds.cellHeight = size.height + 30.0;
            hds.title = @"热门搜索";
            hds.disableDeletion = YES;
            hds.tags = hotSearchModel.data;
            [self.tableView addDataSource:hds];
            [self.tableView refresh];
            
        });
        
    }else{
        
        SearchHistoryCellDataSource *hds = [[self.tableView dataSource] lastObject];
        // Clear Cell
        [[self.tableView dataSource] removeAllObjects];
        [self.tableView refresh];
        
        // Recent Search History
        RecentSearchModel *recentSearchModel = [FJStorage value_jsonmodel:@"RecentSearchModel" key:@"RecentSearch"];
        // Add Cell
        SearchHistoryCellDataSource *sds = [[SearchHistoryCellDataSource alloc] init];
        CGSize size = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH tags:recentSearchModel.history config:[FJTagConfig new]];
        sds.cellHeight = size.height + 30.0;
        sds.title = @"最近搜索";
        sds.tags = recentSearchModel.history;
        [self.tableView addDataSource:sds];
        [self.tableView addDataSource:hds];
        [self.tableView refresh];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end   
