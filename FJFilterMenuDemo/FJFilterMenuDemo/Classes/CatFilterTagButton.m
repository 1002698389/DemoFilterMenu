//
//  CatFilterTagButton.m
//  FJFilterMenuDemo
//

#import "CatFilterTagButton.h"

@interface CatFilterTagButton ()

@property (weak, nonatomic) IBOutlet UILabel *lb_text;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;


@end

@implementation CatFilterTagButton

-(void)awakeFromNib {
    
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.lb_text.font = [UIFont systemFontOfSize:14.0];
    [self cornerRadius:2.0];
    
    MF_WEAK_SELF(self);
    [self.btn_delete bk_addEventHandler:^(id sender) {
        
        MF_BLOCK_CALL(weakSelf.deleteBlock, weakSelf.tag);
        
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)setKeyText:(NSString *)keyText
{
    _keyText = [keyText copy];
    
    self.lb_text.text = keyText;
    CGFloat textWidth = [keyText singleWidthWithLabelFont:[UIFont systemFontOfSize:14] enableCeil:YES];
    self.catWidth = 10.0 + textWidth + 8.0 +14.0 + 8.0;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.catWidth, CatFilterTagButton_Width);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
