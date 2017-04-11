//
//  SearchTuneBarView.m
//  FJFilterMenuDemo
//

#import "SearchTuneBarView.h"
#import "CatFilterTagButton.h"

@interface SearchTuneBarView ()

@property (weak, nonatomic) IBOutlet UIView *v_bm;
@property (weak, nonatomic) IBOutlet UIScrollView *sv_filter;

@property (strong, nonatomic) NSMutableArray *tagArray;

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

- (void)setFilters:(NSMutableArray *)filters
{
    _filters = filters;
    if ([filters count] > 0) {
        self.v_bm.hidden = NO;
        self.tuneBar.hasFilter = YES;
    }else {
        self.v_bm.hidden = YES;
        self.tuneBar.hasFilter = NO;
    }
    
    if (self.tagArray.count  > 0) {
        for (CatFilterTagButton *tagBtn in self.tagArray) {
            [tagBtn removeFromSuperview];
        }
        [self.tagArray removeAllObjects];
    }
    self.tagArray = [[NSMutableArray alloc] init];
    
    MF_WEAK_SELF(self);
    CGFloat btnX = 0;
    for (int i=0; i< filters.count; i++) {
        CategoryFilterSelectModel *model = [filters objectAtIndex:i];
        NSString *name = model.name;
        CatFilterTagButton *btn = MF_LOAD_NIB(@"CatFilterTagButton");
        btn.tag = i;
        btn.keyText = name;
        btn.frame = CGRectMake(btnX, 0, btn.catWidth, CatFilterTagButton_Width);
        btn.deleteBlock = ^(NSInteger tag){
            CategoryFilterSelectModel *model = [weakSelf.filters objectAtIndex:tag];
            MF_BLOCK_CALL(weakSelf.tuneViewDeleteBlock, model);
        };
        
        [self.sv_filter addSubview:btn];
        [self.tagArray addObject:btn];
        
        btnX += btn.catWidth + 10.0;
    }
    
    self.sv_filter.contentSize = CGSizeMake(btnX, 0);
}

- (void)setScrollToTop:(BOOL)toTop
{
    self.sv_filter.scrollsToTop = toTop;
}

@end
