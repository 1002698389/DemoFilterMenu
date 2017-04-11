//
//  SearchAutomatedView.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

@interface SearchAutomatedView : UIView

@property (nonatomic, copy) void(^tagTapped)(NSString *tag);
@property (nonatomic, copy) void(^tagScrolled)(void);

- (void)refresh:(NSString*)keyword;

@end
