//
//  ProductSearchBar.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

#define Product_Search_BarH_Regular (44.0)
#define Product_Search_BarH_Nav     (32.0)

typedef NS_ENUM(NSInteger, PrdSearchBarState) {
    PrdSearchBarState_None,                 // 显示
    PrdSearchBarState_Begin,                // 焦点集中
    PrdSearchBarState_Editing,
    PrdSearchBarState_Return
};

typedef void(^PrdSearchBarBlock)(PrdSearchBarState state, NSString *value);

@interface ProductSearchBar : UIView

@property (nonatomic, weak) IBOutlet UITextField *tf_input;

@property (nonatomic, copy) PrdSearchBarBlock prdSearchBarBlock;

@end
