//
//  CatFilterTagButton.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

#define CatFilterTagButton_Width 24.0

@interface CatFilterTagButton : UIView

@property (copy, nonatomic) NSString *keyText;
@property (assign, nonatomic) CGFloat catWidth;

@property (copy, nonatomic) void (^deleteBlock)(NSInteger index);

@end
