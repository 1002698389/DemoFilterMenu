//
//  FilterTagButton.m
//  FJFilterMenuDemo
//

#import "FilterTagButton.h"

@interface FilterTagButton ()

@property (copy, nonatomic)   NSString *tagName;
@property (assign, nonatomic) CGFloat tagButtonWidth;

@property (weak, nonatomic) IBOutlet UILabel *lb_text;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;


@end

@implementation FilterTagButton

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

// 设置Tag名称
- (void)setTagName:(NSString *)tagName {
    _tagName = [tagName copy];
    
    self.lb_text.text = tagName;
    CGFloat textWidth = [tagName singleWidthWithLabelFont:[UIFont systemFontOfSize:14] enableCeil:YES];
    self.tagButtonWidth = 10.0 + textWidth + 8.0 +14.0 + 8.0;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.tagButtonWidth, FilterTagButton_Width);
}

// 获取FilterTagButton的宽
- (CGFloat)tagButtonWidth {
    return _tagButtonWidth;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
