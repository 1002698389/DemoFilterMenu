//
//  SearchTuneBar.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

#define SearchTuneBarHeight 44.0

typedef NS_ENUM(NSInteger, SearchTuneValue)
{
    SearchTuneValue_Hot,          // 热门
    SearchTuneValue_Discount,     // 折扣
    SearchTuneValue_Price,        // 价格
    SearchTuneValue_Filter,       // 筛选
};

@interface SearchTuneBar : UIView

@property (nonatomic, copy) void(^searchTuneBarBlock)(SearchTuneValue tuneValue, BOOL asc);

@property (assign, nonatomic) BOOL hasFilter;

- (void)selecteTab:(SearchTuneValue)value;

@end
