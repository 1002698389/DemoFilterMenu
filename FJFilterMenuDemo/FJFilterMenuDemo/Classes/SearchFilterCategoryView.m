//
//  SearchFilterCategoryView.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchFilterCategoryView.h"

@interface SearchFilterCategoryView()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation SearchFilterCategoryView

// 添加Category
- (void)addCategories:(NSArray<NSString *> *)categories {
    self.categories = categories;
    
    __weak typeof(self) weakSelf = self;
    
    __block SolidLine *topLine = nil;
    
    for (int i = 0; i < [categories count] ; i++) {
        NSString *category = [categories objectAtIndex:i];
        __block UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:category forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_GRAY_666666 forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        btn.tag = i;
        if ([[categories firstObject] isEqual:category]) {
            btn.backgroundColor = COLOR_PURE_WHITE;
        }else{
            btn.backgroundColor = COLOR_PURE_CLEAR;
        }
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (topLine != nil) {
                make.top.equalTo(topLine.mas_bottom);
                make.left.right.equalTo(weakSelf);
            }else{
                make.top.left.right.equalTo(weakSelf);
            }
            make.height.equalTo(@46);
        }];
        
        topLine = [SolidLine line:CGRectZero orient:LineOrient_RectDown color:COLOR_GRAY_999999];
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_bottom);
            make.left.right.equalTo(weakSelf);
            make.height.equalTo(@1);
        }];
        
        [btn bk_addEventHandler:^(UIButton *sender) {
            
            for (UIButton *b in [weakSelf subviews]) {
                if ([b isKindOfClass:[UIButton class]]) {
                    if ([b isEqual:sender]) {
                        if (![b.backgroundColor isEqual:COLOR_PURE_WHITE]) {
                            [b setBackgroundColor:COLOR_PURE_WHITE];
                            weakSelf.categoryTapped == nil ? : weakSelf.categoryTapped(b.tag, b.titleLabel.text);
                        }
                    }else{
                        [b setBackgroundColor:COLOR_PURE_CLEAR];
                    }
                }
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

// 更新是否有勾选项目
- (void)updateSelected:(BOOL)selected {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
