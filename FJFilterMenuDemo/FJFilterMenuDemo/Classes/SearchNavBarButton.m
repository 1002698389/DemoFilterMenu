//
//  SearchNavBarButton.m
//  FJFilterMenuDemo
//

#import "SearchNavBarButton.h"

#define AniamtionDuration (0.008)
#define ScaleStep (0.05)

@interface SearchNavBarButton()

@property (nonatomic, weak) UIButton *shownBtn;
@property (nonatomic, weak) UIButton *hiddenBtn;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) BOOL animation;

@end

@implementation SearchNavBarButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateHighlighted];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        
        [self addSubview:_cancelBtn];
        __weak typeof(self) weakSelf = self;
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.center.equalTo(weakSelf);
        }];
        
        _cancelBtn.hidden = YES;
    }
    return _cancelBtn;
}

- (UIButton *)messageBtn {
    if (_messageBtn == nil) {
        _messageBtn = [[UIButton alloc] init];
        [_messageBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
        [_messageBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateHighlighted];
        
        [self addSubview:_messageBtn];
        __weak typeof(self) weakSelf = self;
        [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.center.equalTo(weakSelf);
        }];
        
        _messageBtn.hidden = YES;
    }
    return _messageBtn;
}

- (void)setupUI {
    self.cancelBtn.hidden = YES;
    self.messageBtn.hidden = NO;
}

- (void)switchTo:(NSUInteger)index {
    
    if (self.index == index) {
        return;
    }
    
    if (self.animation) {
        return;
    }
    self.animation = YES;
    
    
    self.index = index;
    
    UIButton *hiddenBtn = nil;
    UIButton *shownBtn = nil;
    
    switch (index) {
        case 0:
        {
            hiddenBtn = self.cancelBtn;
            shownBtn = self.messageBtn;
            break;
        }
        case 1:
        {
            hiddenBtn = self.messageBtn;
            shownBtn = self.cancelBtn;
            break;
        }
    }
    
    self.shownBtn = shownBtn;
    self.hiddenBtn = hiddenBtn;
    
    [self animated];
    
}

- (void)scaleDown {
    
    static CGFloat scale = 1.0;
    self.hiddenBtn.hidden = NO;
    self.shownBtn.hidden = YES;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AniamtionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (scale <= 0.0) {
            weakSelf.hiddenBtn.hidden = YES;
            weakSelf.shownBtn.transform = CGAffineTransformMakeScale(scale, scale);
            weakSelf.shownBtn.hidden = NO;
            [weakSelf scaleUp];
            scale = 1.0;
        }else{
            self.hiddenBtn.transform = CGAffineTransformMakeScale(scale, scale);
            scale -= ScaleStep;
            [weakSelf scaleDown];
        }
    });
    
}

- (void)scaleUp {
    static CGFloat scale = 0.0;
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AniamtionDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (scale >= 1.0) {
            scale = 0.0;
            weakSelf.animation = NO;
        }else{
            self.shownBtn.transform = CGAffineTransformMakeScale(scale, scale);
            scale += ScaleStep;
            [weakSelf scaleUp];
        }
    });
}

- (void)animated {
    [self scaleDown];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
