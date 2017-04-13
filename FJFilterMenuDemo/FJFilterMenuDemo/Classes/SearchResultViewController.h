//
//  SearchResultViewController.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>
#import "QueryModel.h"

@interface SearchResultViewController : UIViewController

// 更新搜索Key和Query条件
- (BOOL)updateSearchCriteria:(NSString*)key query:(QueryModel*)query;

@end
