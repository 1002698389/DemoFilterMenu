//
//  FJTextButton.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJTextButton.h"

@interface FJTextButton()

@property (nonatomic, weak) FJTagButtonConfig *config;

@end

@implementation FJTextButton

- (void)setTitle:(NSString *)title config:(FJTagButtonConfig *)config {
    
    self.config = config;
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:config.tagTextColor forState:UIControlStateNormal];
    [self setBackgroundColor:config.tagBackgroundColor];
    self.titleLabel.font = config.tagTextFont;
    if (config.tagBorderWidth > 0) {
        [self cornerRadius:config.tagCornerRadius borderWidth:config.tagBorderWidth boderColor:config.tagBorderColor];
    }
    
    
    
    __weak typeof(self) weakSelf = self;
    [self bk_addEventHandler:^(id sender) {
        [weakSelf updateHighlightedState];
    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)selected {
    return self.tag == 1 ? YES : NO;
}

- (void)updateHighlightedState {
    if (self.config.enableMultiTap) {
        
        UIColor *textColor = nil;
        UIColor *backgroundColor = nil;
        UIColor *borderColor = nil;
        UIFont *textFont = nil;
        UIImage *image = nil;
        
        if (self.tag == 0) {
            textColor = self.config.tagHighlightedTextColor;
            backgroundColor = self.config.tagHighlightedBackgroundColor;
            borderColor = self.config.tagHighlightedBorderColor;
            textFont = self.config.tagHighlightedTextFont;
            if ([self.config.selectedImage isKindOfClass:[NSString class]]) {
                image = [UIImage imageNamed:self.config.selectedImage];
            }else if ([self.config.selectedImage isKindOfClass:[UIImage class]]) {
                image = self.config.selectedImage;
            }
        }else{
            textColor = self.config.tagTextColor;
            backgroundColor = self.config.tagBackgroundColor;
            borderColor = self.config.tagBorderColor;
            textFont = self.config.tagTextFont;
            image = nil;
        }
        
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setBackgroundColor:backgroundColor];
        self.titleLabel.font = textFont;
        if (self.config.tagBorderWidth > 0) {
            [self cornerRadius:self.config.tagCornerRadius borderWidth:self.config.tagBorderWidth boderColor:borderColor];
        }
        [self setImage:image forState:UIControlStateNormal];
        
        
        self.tag = self.tag == 0 ? 1 : 0;
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
