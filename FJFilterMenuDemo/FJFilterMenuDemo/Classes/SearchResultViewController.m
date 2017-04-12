//
//  SearchResultViewController.m
//  FJFilterMenuDemo
//

#import "SearchResultViewController.h"
#import "FJCollectionView+FJRefresh.h"
#import "ProductSearchBar.h"
#import "SearchTuneBarView.h"
#import "ProductCollectionViewCell.h"
#import "SearchFilterView.h"
#import "ProductViewController.h"

@interface SearchResultViewController ()

@property (nonatomic, copy)   NSString *key;
@property (nonatomic, strong) QueryModel *query;
@property (nonatomic, copy) NSString *sortprice;
@property (nonatomic, copy) NSString *sortdiscount;

@property (nonatomic, strong) ProductSearchBar *productSearchBar;
@property (nonatomic, strong) SearchTuneBarView *searchTuneView;
@property (nonatomic, strong) FJCollectionView *collectionView;
@property (nonatomic, strong) SearchFilterView *searchFilterView;

@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, assign) NSUInteger allpage;


@end

@implementation SearchResultViewController

- (ProductSearchBar *)productSearchBar {
    if (_productSearchBar == nil) {
        _productSearchBar = MF_LOAD_NIB(@"ProductSearchBar");
        _productSearchBar.width = UI_SCREEN_WIDTH;
        _productSearchBar.height = 24.0;
        self.navigationItem.titleView = _productSearchBar;
    }
    
    return _productSearchBar;
}

- (SearchTuneBarView *)searchTuneView {
    if (_searchTuneView == nil) {
        _searchTuneView = MF_LOAD_NIB(@"SearchTuneBarView");
        [self.view addSubview:_searchTuneView];
        
        __weak typeof(self) weakSelf = self;
        [_searchTuneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf.view);
            make.height.equalTo(@SearchTuneBarHeight);
        }];
        
        _searchTuneView.tuneViewDeleteBlock = ^(CategoryFilterSelectModel *filterModel) {
            NSLog(@"%@",filterModel);
        };
        
        _searchTuneView.tuneBar.searchTuneBarBlock = ^(SearchTuneValue tuneValue, BOOL asc) {
            switch (tuneValue) {
                case SearchTuneValue_Hot:
                {
                    weakSelf.sortprice = nil;
                    weakSelf.sortdiscount = nil;
                    [weakSelf searchProductFirstPage];
                    break;
                }
                    
                case SearchTuneValue_Price:
                {
                    weakSelf.sortprice = asc ? @"0" : @"1";
                    weakSelf.sortdiscount = nil;
                    [weakSelf searchProductFirstPage];
                    break;
                }
                    
                case SearchTuneValue_Discount:
                {
                    weakSelf.sortdiscount = asc ? @"0" : @"1";
                    weakSelf.sortprice = nil;
                    [weakSelf searchProductFirstPage];
                    break;
                }
                    
                case SearchTuneValue_Filter:
                {
                    [UIView animateWithDuration:0.24 animations:^{
                        [weakSelf searchFilterView].frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
                    }];
                    break;
                }
            }
        };
        
    }
    return _searchTuneView;
}

- (FJCollectionView *)collectionView {
    
    if (_collectionView == nil) {
        _collectionView = [FJCollectionView FJCollectionView:CGRectZero
                                                     bgColor:[UIColor whiteColor]
                                                sectionInset:UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
                                                 columnSpace:5.0
                                              interItemSpace:5.0
                                                headerHeight:0.0
                                                footerHeight:0.0
                                             registerClasses:@[[ProductCollectionViewCell class]]
                                                   columnCnt:2
                                                      sticky:NO];
        [self.view addSubview:_collectionView];
        
        __weak typeof(self) weakSelf = self;
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.searchTuneView.mas_bottom);
            make.left.bottom.right.equalTo(weakSelf.view);
        }];
        
        [_collectionView setCollectionCellActionBlock:^(FJ_CollectionCellBlockType type, NSInteger item, NSInteger section, FJCollectionCellDataSource *cellData) {
            switch (type) {
                case FJ_CollectionCellBlockType_CellCustomizedTapped:
                {
                    NSLog(@"CustomizedTapped");
                    break;
                }
                case FJ_CollectionCellBlockType_CellTapped:
                {
                    NSLog(@"Tapped");
                    ProductCollectionViewCellDataSource *ds = (ProductCollectionViewCellDataSource *)cellData;
                    ProductViewController *productVC = [[ProductViewController alloc] init];
                    productVC.imageURL = ds.imageURL;
                    [weakSelf.navigationController pushViewController:productVC animated:YES];
                    break;
                }
            }
        }];
        
    }
    return _collectionView;
}

- (SearchFilterView *)searchFilterView {
    if (_searchFilterView == nil) {
        _searchFilterView = [[SearchFilterView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
        [_searchFilterView setupUI];
        [MF_Key_Window addSubview:_searchFilterView];
    }
    return _searchFilterView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self productSearchBar];
    [self searchTuneView];
    [self collectionView];
    [self searchProductFirstPage];
    
    // Add Refresh Header / Footer
    __weak typeof(self) weakSelf = self;
    id header = [PeapotRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf searchProductFirstPage];
    }];
    
    id footer = [PeapotRefreshBackFooter
                 footerWithHintViewXib:nil
                 hintViewHeight:0
                 refreshingBlock:^{
                     [weakSelf searchProduct:weakSelf.page + 1 rendered:^(NSUInteger page, NSUInteger allpage, BOOL success, NSString *errmsg) {
                         if (success) {
                             weakSelf.page = page;
                             weakSelf.allpage = allpage;
                             
                             if (weakSelf.page == weakSelf.allpage - 1) {
                                 // 最后一页
                                 [weakSelf.collectionView footer_endRefreshingWithNoMoreData];
                             }else{
                                 [weakSelf.collectionView footer_endRefreshing];
                             }
                             
                         }else{
                             NSLog(@"%@",errmsg);
                         }
                     }];
                 }];
    
    [self.collectionView collectionView].mj_header = header;
    [self.collectionView collectionView].mj_footer = footer;
}

- (void)updateSearchCriteria:(NSString*)key query:(QueryModel*)query {
    self.key = key;
    self.query = query;
}


- (void)searchProductFirstPage {
    __weak typeof(self) weakSelf = self;
    [self searchProduct:0 rendered:^(NSUInteger page, NSUInteger allpage, BOOL success, NSString *errmsg) {
        if (success) {
            weakSelf.page = page;
            weakSelf.allpage = allpage;
            [weakSelf.collectionView header_endRefreshing];
            [weakSelf.collectionView footer_resetState];
        }else{
            NSLog(@"%@", errmsg);
        }
    }];
}


- (void)searchProduct:(NSUInteger)page rendered:(void(^)(NSUInteger page, NSUInteger allpage, BOOL success, NSString *errmsg))rendered {
    
    NSString *key = nil;
    QueryModel *query = nil;
    if ([self.key length] > 0 && self.query != nil) {
        key = self.key;
        query = self.query;
    }else if ([self.key length]) {
        self.key = key;
    }else{
        assert(@"Seach Key or Query Null");
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.view startLoadingAnimation];
    [self searchProductData:page key:key query:query sortprice:self.sortprice sortdiscount:self.sortdiscount dataLoaded:^(NSUInteger page, NSUInteger allpage, id data, BOOL success, NSString *errmsg) {
        
        [weakSelf.view stopLoadingAnimation];
        
        if (page == 0) {
            [[weakSelf.collectionView dataSource] removeAllObjects];
        }
        
        for (NSString *prd in data) {
            ProductCollectionViewCellDataSource *prdds = [[ProductCollectionViewCellDataSource alloc] init];
            prdds.imageURL = prd;
            [weakSelf.collectionView addDataSource:prdds];
        }
        
        [weakSelf.collectionView refresh];
        
        if (page == 0) {
            [[weakSelf.collectionView collectionView] setContentOffset:CGPointMake(0, 0)];
        }
        
        rendered == nil ? : rendered(page, allpage, success, errmsg);
    }];
}

- (void)searchProductData:(NSUInteger)page key:(NSString*)key query:(QueryModel*)query sortprice:(NSString*)sortprice sortdiscount:(NSString*)sortdiscount dataLoaded:(void(^)(NSUInteger page, NSUInteger allpage, id data, BOOL success, NSString *errmsg))dataLoaded {
    
    static NSUInteger _simulatedPage    = 0;
    static NSUInteger _simulatedAllpage = 3;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (page == 0) {
            _simulatedPage = 0;
        }else{
            _simulatedPage += 1;
        }
        NSArray *data = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"];
        dataLoaded == nil ? : dataLoaded(_simulatedPage, _simulatedAllpage, data, YES, nil);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
