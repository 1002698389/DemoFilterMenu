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
        [weakSelf setHighlighted];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self bk_addEventHandler:^(id sender) {
        [weakSelf setUnHighlighted];
    } forControlEvents:UIControlEventTouchUpOutside];
    
}

- (void)setHighlighted {
    if (self.config.enableMultiTap) {
        
        UIColor *textColor = nil;
        UIColor *backgroundColor = nil;
        UIColor *borderColor = nil;
        UIFont *textFont = nil;
        
        if (self.tag == 0) {
            textColor = self.config.tagHighlightedTextColor;
            backgroundColor = self.config.tagHighlightedBackgroundColor;
            borderColor = self.config.tagHighlightedBorderColor;
            textFont = self.config.tagHighlightedTextFont;
        }else{
            textColor = self.config.tagTextColor;
            backgroundColor = self.config.tagBackgroundColor;
            borderColor = self.config.tagBorderColor;
            textFont = self.config.tagTextFont;
        }
        
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setBackgroundColor:backgroundColor];
        self.titleLabel.font = textFont;
        if (self.config.tagBorderWidth > 0) {
            [self cornerRadius:self.config.tagCornerRadius borderWidth:self.config.tagBorderWidth boderColor:borderColor];
        }
        
        self.tag = self.tag == 0 ? 1 : 0;
        
        NSLog(@"Tag : %d", self.tag);
        
    }
    
}

- (void)setUnHighlighted {
    if (self.config.enableMultiTap) {
        
        UIColor *textColor = nil;
        UIColor *backgroundColor = nil;
        UIColor *borderColor = nil;
        UIFont *textFont = nil;
        
        if (self.tag == 1) {
            textColor = self.config.tagHighlightedTextColor;
            backgroundColor = self.config.tagHighlightedBackgroundColor;
            borderColor = self.config.tagHighlightedBorderColor;
            textFont = self.config.tagHighlightedTextFont;
        }else{
            textColor = self.config.tagTextColor;
            backgroundColor = self.config.tagBackgroundColor;
            borderColor = self.config.tagBorderColor;
            textFont = self.config.tagTextFont;
        }
        
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self setBackgroundColor:backgroundColor];
        self.titleLabel.font = textFont;
        if (self.config.tagBorderWidth > 0) {
            [self cornerRadius:self.config.tagCornerRadius borderWidth:self.config.tagBorderWidth boderColor:borderColor];
        }
        
        self.tag = self.tag == 0 ? 1 : 0;
        
        NSLog(@"Tag : %d", self.tag);
        
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
