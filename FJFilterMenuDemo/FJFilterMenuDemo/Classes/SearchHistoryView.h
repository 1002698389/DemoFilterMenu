//
//  SearchHistoryView.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

@interface SearchHistoryView : UIView

@property (nonatomic, copy) void(^tagTapped)(NSString *tag);
@property (nonatomic, copy) void(^tagScrolled)(void);

- (void)refresh:(BOOL)hotSearch;

@end
