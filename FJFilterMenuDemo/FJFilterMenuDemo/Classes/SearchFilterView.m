//
//  SearchFilterView.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/11.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchFilterView.h"
#import "SearchFilterCategoryView.h"
#import "NSArray+JSONModel.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"
#import "FilterGroupCell.h"
#import "FilterGroupHeaderView.h"
#import "FilterTuningBrandCell.h"
#import "FilterTuningSellerCell.h"
#import "FilterPriceCell.h"
#import "FilterCustomPriceCell.h"
#import "FilterSelectModel.h"
#import "NSArray+FJTagModel.h"

@interface SearchFilterView()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) FJTableView *groupView;
@property (nonatomic, strong) FJTableView *brandView;
@property (nonatomic, strong) FJTableView *sellerView;
@property (nonatomic, strong) FJTableView *priceView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) SolidLine *headerLine;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, weak)   SearchFilterCategoryView *searchFilterCategoryView;
@property (nonatomic, strong) FJTagConfig *tagConfig;


@property (nonatomic, strong) NSMutableArray<FilterSelectModel *> *selectedCategories;
@property (nonatomic, strong) NSMutableArray<FilterSelectModel *> *selectedBrands;
@property (nonatomic, strong) NSMutableArray<FilterSelectModel *> *selectedSellers;
@property (nonatomic, strong) FilterSelectModel *selectedPrice;


@end

@implementation SearchFilterView

- (NSMutableArray<FilterSelectModel *> *)selectedCategories {
    if (_selectedCategories == nil) {
        _selectedCategories = (NSMutableArray<FilterSelectModel *> *)[[NSMutableArray alloc] init];
    }
    return _selectedCategories;
}

- (NSMutableArray<FilterSelectModel *> *)selectedBrands {
    if (_selectedBrands == nil) {
        _selectedBrands = (NSMutableArray<FilterSelectModel *> *)[[NSMutableArray alloc] init];
    }
    return _selectedBrands;
}

- (NSMutableArray<FilterSelectModel *> *)selectedSellers {
    if (_selectedSellers == nil) {
        _selectedSellers = (NSMutableArray<FilterSelectModel *> *)[[NSMutableArray alloc] init];
    }
    return _selectedSellers;
}

- (FilterSelectModel *)selectedPrice {
    if (_selectedPrice == nil) {
        _selectedPrice = [[FilterSelectModel alloc] init];
        _selectedPrice.type = FilterType_Price;
    }
    return _selectedPrice;
}


// 初始化UI
- (void)setupUI {
    
    __weak typeof(self) weakSelf = self;
    // Background Color
    self.backgroundColor = COLOR_PURE_WHITE;
    
    // Title
    UILabel *lb_title = [[UILabel alloc] init];
    lb_title.text = @"筛选";
    lb_title.font = [UIFont systemFontOfSize:16.0];
    lb_title.textColor = COLOR_GRAY_333333;
    [self addSubview:lb_title];
    [lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_top).offset(20+22);
    }];
    
    SolidLine *headerLine = [SolidLine line:CGRectZero orient:LineOrient_RectUp color:COLOR_GRAY_999999];
    [self addSubview:headerLine];
    [headerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(64.0);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@1.0);
    }];
    self.headerLine = headerLine;
    
    // 关闭按钮
    UIImageView *iv_close = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_close_black"]];
    iv_close.contentMode = UIViewContentModeCenter;
    [self addSubview:iv_close];
    
    [iv_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.top.equalTo(weakSelf).offset(20);
        make.left.equalTo(weakSelf);
    }];
    
    [iv_close setUserInteractionEnabled:YES];
    [iv_close bk_whenTapped:^{
        [weakSelf close];
    }];
    
    // 重置按钮
    UIButton *resetBtn = [[UIButton alloc] init];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:COLOR_GRAY_999999 forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:resetBtn];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.top.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf);
    }];
    
    [resetBtn bk_addEventHandler:^(id sender) {
        [weakSelf renderGroup:YES];
        [weakSelf renderTuning:YES inloading:NO];
        [weakSelf.searchFilterCategoryView reset];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    // 确定按钮
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weakSelf);
        make.height.equalTo(@66);
    }];
    self.bottomView = bottomView;
    
    SolidLine *solidLine = [SolidLine line:CGRectZero orient:LineOrient_RectUp color:COLOR_GRAY_999999];
    __weak typeof(bottomView) weakBottomView = bottomView;
    [bottomView addSubview:solidLine];
    [solidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakBottomView);
        make.height.equalTo(@1);
    }];
    
    UIButton *bottomBtn = [[UIButton alloc] init];
    bottomBtn.backgroundColor = COLOR_GRAY_333333;
    [bottomBtn cornerRadius:4.0];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [bottomView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakBottomView).offset(10.0);
        make.bottom.right.equalTo(weakBottomView).offset(-10.0);
    }];
    [bottomBtn bk_addEventHandler:^(id sender) {
        [weakSelf confirm];
    } forControlEvents:UIControlEventTouchUpInside];
    
    // LeftView
    [self leftView];
    // TableView
    [self brandView];
    [self sellerView];
    [self priceView];
    [self groupView];
    
}

- (UIView *)leftView {
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = COLOR_TEXT_PURPLE;
        [self addSubview:_leftView];
        __weak typeof(self) weakSelf = self;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.width.equalTo(@100);
        }];
        
        SolidLine *rightLine = [SolidLine line:CGRectZero orient:LineOrient_RectRight color:COLOR_GRAY_999999];
        [_leftView addSubview:rightLine];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(_leftView);
            make.width.equalTo(@1);
        }];
        
        SearchFilterCategoryView *categoryView = [[SearchFilterCategoryView alloc] init];
        [_leftView addSubview:categoryView];
        [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_leftView);
        }];
        self.searchFilterCategoryView = categoryView;
        
        categoryView.backgroundColor = COLOR_PURE_CLEAR;
        // TODO
        [categoryView addCategories:@[@"分类",@"品牌",@"商家",@"价格"]];
        categoryView.categoryTapped = ^(NSUInteger index, NSString *category) {
            NSLog(@"%d %@", (int)index, category);
            
            switch (index) {
                case 0:
                {
                    [weakSelf bringSubviewToFront:weakSelf.groupView];
                    break;
                }
                case 1:
                {
                    [weakSelf bringSubviewToFront:weakSelf.brandView];
                    break;
                }
                case 2:
                {
                    [weakSelf bringSubviewToFront:weakSelf.sellerView];
                    break;
                }
                case 3:
                {
                    [weakSelf bringSubviewToFront:weakSelf.priceView];
                    break;
                }
            }
            
            [self bringSubviewToFront:_indicatorView];
        };
        
    }
    return _leftView;
}

- (FJTableView *)groupView {
    if (_groupView == nil) {
        _groupView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor whiteColor]];
        [self addSubview:_groupView];
        __weak typeof(self) weakSelf = self;
        [_groupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
        
        [_groupView setCellActionBlock:^(FJ_CellBlockType type, NSInteger row, NSInteger section, __kindof FJCellDataSource *cellData) {
            if (type == FJ_CellBlockType_CellCustomizedTapped) {
                if ([cellData isKindOfClass:[FilterGroupCellDataSource class]]) {
                    FilterGroupCellDataSource *ds = cellData;
                    if (ds.selected) {
                        if (![weakSelf.selectedCategories containsTagModel:ds.selectedCategory]) {
                             [weakSelf.selectedCategories addObject:ds.selectedCategory];
                        }
                    }else{
                        [weakSelf.selectedCategories removeTagModel:ds.selectedCategory];
                    }
                    NSLog(@"Selected Categories : %@", weakSelf.selectedCategories);
                    
                    if ([weakSelf.selectedCategories count] > 0) {
                        [weakSelf.searchFilterCategoryView updateSelected:YES];
                    }else{
                        [weakSelf.searchFilterCategoryView updateSelected:NO];
                    }
                    
                    // TODO(加载品牌、商家和价格数据)
                    [weakSelf.indicatorView startAnimating];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.indicatorView stopAnimating];
                        weakSelf.indicatorView.hidden = YES;
                        [weakSelf renderTuning:YES inloading:NO];
                    });
                }else if ([cellData isKindOfClass:[FilterGroupHeaderViewDataSource class]]) {

                    for (FJMultiDataSource *mds in [weakSelf.groupView dataSource]) {
                        if ([mds.headerViewDataSource isEqual:cellData]) {
                            FilterGroupCellDataSource *ds = [mds.cellDataSources objectAtIndex:0];
                            [weakSelf.groupView autoExtendAndCollapse:ds];
                            FilterGroupCell *cell = [weakSelf.groupView cellForDataSource:ds];
                            [cell autoExtendAndCollapse];
                            break;
                        }
                    }
                    
                    NSLog(@"Header Tapped");
                }
            }
        }];
    }
    return _groupView;
}

- (FJTableView *)brandView {
    if (_brandView == nil) {
        _brandView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor whiteColor]];
        [self addSubview:_brandView];
        __weak typeof(self) weakSelf = self;
        [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
        
        [_brandView setCellActionBlock:^(FJ_CellBlockType type, NSInteger row, NSInteger section, __kindof FJCellDataSource *cellData) {
            if (type == FJ_CellBlockType_CellCustomizedTapped) {
                if ([cellData isKindOfClass:[FilterTuningBrandCellDataSource class]]) {
                    FilterTuningBrandCellDataSource *ds = cellData;
                    if (ds.brand.selected) {
                        if (![weakSelf.selectedBrands containsTagModel:ds.brand]) {
                            [weakSelf.selectedBrands addObject:ds.brand];
                        }
                    }else{
                        [weakSelf.selectedBrands removeTagModel:ds.brand];
                    }
                }
            }
        }];
    }
    return _brandView;
}

- (FJTableView *)sellerView {
    if (_sellerView == nil) {
        _sellerView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor whiteColor]];
        [self addSubview:_sellerView];
        __weak typeof(self) weakSelf = self;
        [_sellerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
        
        [_sellerView setCellActionBlock:^(FJ_CellBlockType type, NSInteger row, NSInteger section, __kindof FJCellDataSource *cellData) {
            if (type == FJ_CellBlockType_CellCustomizedTapped) {
                if ([cellData isKindOfClass:[FilterTuningSellerCellDataSource class]]) {
                    FilterTuningSellerCellDataSource *ds = cellData;
                    if (ds.seller.selected) {
                        if (![weakSelf.selectedSellers containsTagModel:ds.seller]) {
                            [weakSelf.selectedSellers addObject:ds.seller];
                        }
                    }else{
                        [weakSelf.selectedSellers removeTagModel:ds.seller];
                    }
                }
            }
        }];
    }
    return _sellerView;
}

- (FJTableView *)priceView {
    if (_priceView == nil) {
        _priceView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor whiteColor]];
        [self addSubview:_priceView];
        __weak typeof(self) weakSelf = self;
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
    }
    return _priceView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_indicatorView];
        __weak typeof(self) weakSelf = self;
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX).offset(50.0);
            make.centerY.equalTo(weakSelf.mas_centerY);
        }];
    }
    [self bringSubviewToFront:_indicatorView];
    _indicatorView.hidden = NO;
    return _indicatorView;
}

- (void)close {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.24 animations:^{
        weakSelf.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    }];
}

- (void)confirm {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.24 animations:^{
        weakSelf.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        // TODO (选中的Tuning参数)
        // TODO Category
        // TODO Brand / Seller / Price
        
        weakSelf.filterSelectedTuning == nil ? : weakSelf.filterSelectedTuning(self.selectedCategories, self.selectedBrands, self.selectedSellers, self.selectedPrice);
    }];
}

- (void)setGroup:(NSMutableArray<ProductGroup> *)group {
    if ([_group equal:group]) {
        return;
    }
    _group = group;
}

// 加载Category
- (void)renderGroup:(BOOL)refresh {
    
    // Refresh
    if (refresh) {
        [self.selectedCategories removeAllObjects];
    }
    
    // Render Group
    [[self.groupView dataSource] removeAllObjects];
    
    // TODO Simulation
    FJMultiDataSource *mds = [[FJMultiDataSource alloc] init];
    mds.cellDataSources = (NSMutableArray<FJCellDataSource> *)[[NSMutableArray alloc] init];
    
    // Group Header View
    FilterGroupHeaderViewDataSource *hds = [[FilterGroupHeaderViewDataSource alloc] init];
    hds.rootCategory = @"男装";
    mds.headerViewDataSource = hds;
    // Group Cell
    FilterGroupCellDataSource *fds = [[FilterGroupCellDataSource alloc] init];
    fds.tagConfig = [self tagConfig];
    fds.lastCategories = [FilterSelectModel fake:@[@"AAAAA",@"BBBB",@"CCCC",@"DDDD"] type:FilterType_Category];
    fds.selectedCategories = self.selectedCategories;
    fds.cellHeightExtended = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH - 100.0 tags:fds.lastCategories config:[self tagConfig]].height;
    fds.cellHeight = 1.0;
    fds.extended = YES;
    [mds.cellDataSources addObject:fds];
    [self.groupView addDataSource:mds];
    
    mds = [[FJMultiDataSource alloc] init];
    mds.cellDataSources = (NSMutableArray<FJCellDataSource> *)[[NSMutableArray alloc] init];
    // Group Header View
    hds = [[FilterGroupHeaderViewDataSource alloc] init];
    hds.rootCategory = @"女装";
    mds.headerViewDataSource = hds;
    // Group Cell
    fds = [[FilterGroupCellDataSource alloc] init];
    fds.tagConfig = [self tagConfig];
    fds.lastCategories = [FilterSelectModel fake:@[@"上衣",@"外套",@"裤子",@"帽子",@"鞋子",@"好看的眼镜",@"披风",@"棉袄",@"大棉袄",@"外衣",@"视频",@"新闻",@"全球",@"孙武",@"孙文",@"HelloKitty",@"药物",@"琼瑶",@"好一些",@"没有了"] type:FilterType_Category];
    fds.selectedCategories = self.selectedCategories;
    fds.cellHeightExtended = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH - 100.0 tags:fds.lastCategories config:[self tagConfig]].height;
    fds.cellHeight = 1.0;
    [mds.cellDataSources addObject:fds];
    [self.groupView addDataSource:mds];
    
    mds = [[FJMultiDataSource alloc] init];
    mds.cellDataSources = (NSMutableArray<FJCellDataSource> *)[[NSMutableArray alloc] init];
    // Group Header View
    hds = [[FilterGroupHeaderViewDataSource alloc] init];
    hds.rootCategory = @"童装";
    mds.headerViewDataSource = hds;
    // Group Cell
    fds = [[FilterGroupCellDataSource alloc] init];
    fds.tagConfig = [self tagConfig];
    fds.lastCategories = [FilterSelectModel fake:@[@"EEEEEE",@"FF",@"FF",@"GGGGGGGGGGGGGGGGGGGGGGGGGGGGG",@"KKKK"] type:FilterType_Category];
    fds.selectedCategories = self.selectedCategories;
    fds.cellHeightExtended = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH - 100.0 tags:fds.lastCategories config:[self tagConfig]].height;
    fds.cellHeight = 1.0;
    [mds.cellDataSources addObject:fds];
    [self.groupView addDataSource:mds];
    
    if (refresh) {
        [[self.groupView tableView] setContentOffset:CGPointZero];
    }
    
    [self.groupView refresh];
}

// 加载品牌、商家、价格
- (void)renderTuning:(BOOL)refresh inloading:(BOOL)inloading {
    
    // Refresh
    if (refresh) {
        [self.selectedBrands removeAllObjects];
        [self.selectedSellers removeAllObjects];
        self.selectedPrice = nil;
    }
    
    // Render Brand、Seller、Price
    if ([[self.brandView dataSource] count] > 0) {
        [[self.brandView dataSource] removeAllObjects];
        [self.brandView refresh];
    }
    if ([[self.sellerView dataSource] count] > 0) {
        [[self.sellerView dataSource] removeAllObjects];
        [self.sellerView refresh];
    }
    if ([[self.priceView dataSource] count] > 0) {
        [[self.priceView dataSource] removeAllObjects];
        [self.priceView refresh];
    }
    
    if (inloading) {
        self.brandView.fj_view_bgColor  = COLOR_PURE_WHITE;
        self.sellerView.fj_view_bgColor = COLOR_PURE_WHITE;
        self.priceView.fj_view_bgColor  = COLOR_PURE_WHITE;
        return;
    }
    
    // Brand
    for (int i = 0; i < 20; i++) {
        FilterTuningBrandCellDataSource *bds = [[FilterTuningBrandCellDataSource alloc] init];
        FilterSelectModel *brand = [FilterSelectModel filterSelectModel:FilterType_Brand name:[NSString stringWithFormat:@"Nike%d",i]];
        bds.brand = brand;
        [self.brandView addDataSource:bds];
    }
    [self.brandView refresh];
    
    // Seller
    for (int i = 0; i < 20; i++) {
        FilterTuningSellerCellDataSource *sds = [[FilterTuningSellerCellDataSource alloc] init];
        FilterSelectModel *seller = [FilterSelectModel filterSelectModel:FilterType_Brand name:[NSString stringWithFormat:@"Amazon%d",i]];
        sds.seller = seller;
        [self.sellerView addDataSource:sds];
    }
    [self.sellerView refresh];
    
    // Price
    FilterPriceCellDataSource *pds = [[FilterPriceCellDataSource alloc] init];
    pds.allPrice = YES;
    [self.priceView addDataSource:pds];
    FilterCustomPriceCellDataSource *pcds = [[FilterCustomPriceCellDataSource alloc] init];
    [self.priceView addDataSource:pcds];
    [self.priceView refresh];
}

- (FJTagConfig *)tagConfig {
    
    if (_tagConfig == nil) {
        FJTagConfig *config = [FJTagConfig new];
        config.enableMultiTap = YES;
        config.tagTextFont = [UIFont systemFontOfSize:12.0];
        config.tagTextColor = COLOR_GRAY_666666;
        config.tagBackgroundColor = COLOR_TEXT_PURPLE;
        config.tagBorderColor = COLOR_PURE_CLEAR;
        config.tagBorderWidth = 0.5;
        config.tagCornerRadius = 2.0;
        config.itemMinWidth = 106.0;
        config.itemMinHeight = 26.0;
        config.paddingTop = 20.0;
        config.paddingLeft = 20.0;
        config.paddingBottom = 20.0;
        config.paddingRight = 20.0;
        config.itemHorizontalSpace = 18.0;
        config.itemVerticalSpace = 16.0;
        config.tagHighlightedTextFont = [UIFont systemFontOfSize:12.0];
        config.tagHighlightedTextColor = COLOR_GRAY_333333;
        config.tagHighlightedBackgroundColor = COLOR_PURE_WHITE;
        config.tagHighlightedBorderColor = COLOR_GRAY_26241F;
        config.selectedImage = @"icon_selected";
        config.selectedImageSize = CGSizeMake(12.0, 12.0);
        config.itemPaddingLeft = 5.0;
        config.itemPaddingRight = 5.0;
        config.debug = NO;
        _tagConfig = config;
    }
    return _tagConfig;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
