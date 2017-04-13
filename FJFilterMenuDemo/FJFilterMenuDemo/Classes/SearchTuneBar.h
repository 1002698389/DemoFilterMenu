//
//  SearchTuneBar.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

#define SearchTuneBarHeight 44.0

typedef NS_ENUM(NSInteger, SearchTab)
{
    SearchTab_Hot,          // 热门
    SearchTab_Discount,     // 折扣
    SearchTab_Price,        // 价格
    SearchTab_Filter,       // 筛选
};

@interface SearchTuneBar : UIView

// 选中后实时Search排序状态的Block
@property (nonatomic, copy) void(^searchTabTappedBlock)(SearchTab tab, BOOL asc);

// 高亮Search Tab
- (void)setSearchTabHighlighted:(BOOL)searchTabHighlighted;

// 点击某个Search Tab(有些是排序、有些是单击选项)
- (void)selecetSearchTab:(SearchTab)tab;

@end
