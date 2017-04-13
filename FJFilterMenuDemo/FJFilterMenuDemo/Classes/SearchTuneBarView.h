//
//  SearchTuneBarView.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>
#import "SearchTuneBar.h"
#import "FilterSelectModel.h"

#define SearchTuneBarView_BM_H  (44.0)
#define SearchTuneBarView_Min_H SearchTuneBarHeight
#define SearchTuneBarView_Max_H (SearchTuneBarView_Min_H + SearchTuneBarView_BM_H)

@interface SearchTuneBarView : UIView

// TuneBar控件
@property (nonatomic, strong) SearchTuneBar *tuneBar;

// FilterTagButton删除Block
@property (nonatomic, copy) void (^filterTagButtonDeleteBlock)(FilterSelectModel *filter);

// 设置筛选结果数据
- (void)setFilters:(NSMutableArray<FilterSelectModel *> *)filters;

// 滚动至最前端
- (void)setScrollToTop:(BOOL)toTop;

@end
