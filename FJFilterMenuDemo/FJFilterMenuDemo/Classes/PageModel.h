//
//  PageModel.h
//  FJFilterMenuDemo
//

#import "MyModel.h"

#define PerPage_Count 10

@interface PageModel : MyModel

@property (nonatomic, assign) int allpage;    // 页数总数
@property (nonatomic, assign) int count;      // 当页总数
@property (nonatomic, assign) int page;       // 页码

- (BOOL)isFirstPage;
- (BOOL)isLastPage;

@end
