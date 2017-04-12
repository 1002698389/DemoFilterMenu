//
//  SearchTuneBarView.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>
#import "SearchTuneBar.h"
#import "CategoryFilterData.h"

#define SearchTuneBarView_BM_H 44.0
#define SearchTuneBarView_Min_H SearchTuneBarHeight
#define SearchTuneBarView_Max_H (SearchTuneBarView_Min_H + SearchTuneBarView_BM_H)

@interface SearchTuneBarView : UIView

@property (strong, nonatomic) SearchTuneBar *tuneBar;

@property (copy, nonatomic) void (^tuneViewDeleteBlock)(CategoryFilterSelectModel *filter);

// 筛选数据
@property (strong, nonatomic) NSMutableArray<CategoryFilterSelectModel *> *filters;

- (void)setScrollToTop:(BOOL)toTop;

@end
