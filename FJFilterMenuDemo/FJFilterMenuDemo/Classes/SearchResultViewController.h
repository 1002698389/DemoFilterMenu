//
//  SearchResultViewController.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>
#import "QueryModel.h"

@interface SearchResultViewController : UIViewController

- (void)updateSearchCriteria:(NSString*)key query:(QueryModel*)query;

@end
