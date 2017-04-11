//
//  ProductSearchBar.m
//  FJFilterMenuDemo
//

#import "ProductSearchBar.h"

@interface ProductSearchBar ()

@property (weak, nonatomic) IBOutlet UIView *v_bg;

@property (assign, nonatomic) PrdSearchBarState state;


@end

@implementation ProductSearchBar

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    [self cornerRadius:4.0];
    _tf_input.tintColor = COLOR_GRAY_999999;
    _tf_input.font = [UIFont systemFontOfSize:12.0];
    
    MF_WEAK_SELF(self);
    [[[_tf_input.rac_textSignal filter:^BOOL(NSString *txt) {
        if (weakSelf.state == PrdSearchBarState_None) {
            weakSelf.state = PrdSearchBarState_Begin;
            return NO;
        }else if (weakSelf.state == PrdSearchBarState_Begin) {
            weakSelf.state = PrdSearchBarState_Editing;
            return NO;
        }else {
            return YES;
        }
    }] throttle:1.0] subscribeNext:^(id x) {
        MF_BLOCK_CALL_2_P(_prdSearchBarBlock, PrdSearchBarState_Editing, x);
    }];
    
    // 失去焦点
    [self.tf_input setBk_didEndEditingBlock:^(UITextField *tf) {
        
        self.state = PrdSearchBarState_Begin;
    }];
    
    [self.tf_input setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        MF_BLOCK_CALL_2_P(_prdSearchBarBlock, PrdSearchBarState_Return, textField.text);
        return YES;
    }];
}

@end
