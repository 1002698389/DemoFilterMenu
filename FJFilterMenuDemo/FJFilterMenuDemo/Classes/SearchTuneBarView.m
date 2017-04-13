//
//  SearchTuneBarView.m
//  FJFilterMenuDemo
//

#import "SearchTuneBarView.h"
#import "FilterTagButton.h"

@interface SearchTuneBarView ()

@property (weak, nonatomic) IBOutlet UIView *v_bm;
@property (weak, nonatomic) IBOutlet UIScrollView *sv_filter;
@property (strong, nonatomic) NSMutableArray *tagArray;

// 筛选数据
@property (strong, nonatomic) NSMutableArray<FilterSelectModel *> *filters;

@end

@implementation SearchTuneBarView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self tuneBar];
}

- (SearchTuneBar *)tuneBar
{
    if (!_tuneBar) {
        _tuneBar = MF_LOAD_NIB(@"SearchTuneBar");
        _tuneBar.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, SearchTuneBarHeight);
        [self addSubview:_tuneBar];
    }
    return _tuneBar;
}

// 设置筛选结果数据
- (void)setFilters:(NSMutableArray<FilterSelectModel *> *)filters
{
    _filters = filters;
    if ([filters count] > 0) {
        self.v_bm.hidden = NO;
        [self.tuneBar setSearchTabHighlighted:YES];
    }else {
        self.v_bm.hidden = YES;
        [self.tuneBar setSearchTabHighlighted:NO];
    }
    
    if (self.tagArray.count  > 0) {
        for (FilterTagButton *tagBtn in self.tagArray) {
            [tagBtn removeFromSuperview];
        }
        [self.tagArray removeAllObjects];
    }
    self.tagArray = [[NSMutableArray alloc] init];
    
    MF_WEAK_SELF(self);
    CGFloat btnX = 0;
    for (int i=0; i< filters.count; i++) {
        FilterSelectModel *model = [filters objectAtIndex:i];
        NSString *name = model.name;
        FilterTagButton *btn = MF_LOAD_NIB(@"FilterTagButton");
        btn.tag = i;
        [btn setTagName:name];
        btn.frame = CGRectMake(btnX, 0, [btn tagButtonWidth], FilterTagButton_Width);
        btn.deleteBlock = ^(NSInteger tag){
            FilterSelectModel *model = [weakSelf.filters objectAtIndex:tag];
            MF_BLOCK_CALL(weakSelf.filterTagButtonDeleteBlock, model);
        };
        
        [self.sv_filter addSubview:btn];
        [self.tagArray addObject:btn];
        
        btnX += [btn tagButtonWidth] + 10.0;
    }
    
    self.sv_filter.contentSize = CGSizeMake(btnX, 0);
}

// 滚动至最前端
- (void)setScrollToTop:(BOOL)toTop
{
    self.sv_filter.scrollsToTop = toTop;
}

@end
