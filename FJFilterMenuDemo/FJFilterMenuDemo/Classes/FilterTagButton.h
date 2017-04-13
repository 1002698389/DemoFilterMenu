//
//  FilterTagButton.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

#define FilterTagButton_Width 24.0

@interface FilterTagButton : UIView

// 设置Tag名称
- (void)setTagName:(NSString *)tagName;

// 获取FilterTagButton的宽
- (CGFloat)tagButtonWidth;

// 设置点击删除TagButton的Block
@property (copy, nonatomic) void (^deleteBlock)(NSInteger index);

@end
