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
#import "FilterGroupCell.h"
#import "FilterGroupHeaderView.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"

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
@property (nonatomic, strong) NSMutableSet<NSString *> *selectedCategories;

@end

@implementation SearchFilterView

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
        [weakSelf close];
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
                    [self bringSubviewToFront:self.groupView];
                    break;
                }
                case 1:
                {
                    [self bringSubviewToFront:self.brandView];
                    break;
                }
                case 2:
                {
                    [self bringSubviewToFront:self.sellerView];
                    break;
                }
                case 3:
                {
                    [self bringSubviewToFront:self.priceView];
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
                    if (weakSelf.selectedCategories == nil) {
                        weakSelf.selectedCategories = [[NSMutableSet alloc] init];
                    }
                    if (ds.selected) {
                        [weakSelf.selectedCategories addObject:ds.selectedCategory];
                    }else{
                        [weakSelf.selectedCategories removeObject:ds.selectedCategory];
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
                    });
                }else if ([cellData isKindOfClass:[FilterGroupHeaderViewDataSource class]]) {
                
                }
            }
        }];
    }
    return _groupView;
}

- (FJTableView *)brandView {
    if (_brandView == nil) {
        _brandView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor redColor]];
        [self addSubview:_brandView];
        __weak typeof(self) weakSelf = self;
        [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
    }
    return _brandView;
}

- (FJTableView *)sellerView {
    if (_sellerView == nil) {
        _sellerView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor yellowColor]];
        [self addSubview:_sellerView];
        __weak typeof(self) weakSelf = self;
        [_sellerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
    }
    return _sellerView;
}

- (FJTableView *)priceView {
    if (_priceView == nil) {
        _priceView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor greenColor]];
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
    } completion:^(BOOL finished) {
        // TODO (选中的Tuning参数)
        CategoryFilterSelectModel *filter = [[CategoryFilterSelectModel alloc] init];
        filter.type = CategoryFilterGroupType_Category;
        filter.selected = YES;
        filter.name = @"线裤";
        
        weakSelf.filterSelectedTuning == nil ? : weakSelf.filterSelectedTuning(@[filter,filter,filter,filter,filter,filter]);
    }];
}

- (void)setGroup:(NSMutableArray<ProductGroup> *)group {
    if ([_group equal:group]) {
        return;
    }
    _group = group;
}

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
    fds.lastCategories = @[@"AAAAA",@"BBBB",@"CCCC",@"DDDD"];
    fds.selectedCategories = (NSArray<NSString *> *)[self.selectedCategories allObjects];
    fds.cellHeight = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH - 100.0 tags:fds.lastCategories config:[self tagConfig]].height;
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
    fds.lastCategories = @[@"上衣",@"外套",@"裤子",@"帽子",@"鞋子",@"好看的眼镜",@"披风",@"棉袄",@"大棉袄",@"上衣",@"外套",@"裤子",@"帽子",@"鞋子",@"好看的眼镜",@"披风",@"棉袄",@"大棉袄"];
    fds.selectedCategories = (NSArray<NSString *> *)[self.selectedCategories allObjects];
    fds.cellHeight = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH - 100.0 tags:fds.lastCategories config:[self tagConfig]].height;
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
    fds.lastCategories = @[@"EEEEEE",@"FF",@"GGGGGGGGGGGGGGGGGGGGGGGGGGGGG",@"KKKK"];
    fds.selectedCategories = (NSArray<NSString *> *)[self.selectedCategories allObjects];
    fds.cellHeight = [FJTagCollectionView calculateSize:UI_SCREEN_WIDTH - 100.0 tags:fds.lastCategories config:[self tagConfig]].height;
    [mds.cellDataSources addObject:fds];
    [self.groupView addDataSource:mds];
    
    if (refresh) {
        [[self.groupView tableView] setContentOffset:CGPointZero];
    }

    [self.groupView refresh];
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
