//
//  SearchNavBarButton.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

@interface SearchNavBarButton : UIView

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *messageBtn;

- (void)setupUI;
- (void)switchTo:(NSUInteger)index completion:(void(^)(void))completion;

@end
