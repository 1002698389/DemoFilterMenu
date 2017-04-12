//
//  SearchResultViewController.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>
#import "QueryModel.h"

@interface SearchResultViewController : UIViewController

- (BOOL)updateSearchCriteria:(NSString*)key query:(QueryModel*)query;

@end
