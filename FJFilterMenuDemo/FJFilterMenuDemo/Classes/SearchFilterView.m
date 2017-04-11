//
//  SearchFilterView.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/11.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchFilterView.h"

@interface SearchFilterView()

@property (nonatomic, strong) FJTableView *leftView;
@property (nonatomic, strong) FJTableView *rightView;
@property (nonatomic, strong) SolidLine *headerLine;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation SearchFilterView

- (void)setupUI {
    
    __weak typeof(self) weakSelf = self;
    // Background Color
    self.backgroundColor = COLOR_PURE_WHITE;
    
    // Title
    UILabel *lb_title = [[UILabel alloc] init];
    lb_title.text = @"筛选";
    lb_title.font = [UIFont systemFontOfSize:16.0];
    lb_title.textColor = COLOR_GRAY_333333;
    [self addSubview:lb_title];
    [lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_top).offset(20+22);
    }];
    
    SolidLine *headerLine = [SolidLine line:CGRectZero orient:LineOrient_RectUp color:COLOR_GRAY_999999];
    [self addSubview:headerLine];
    [headerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(64.0);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@1.0);
    }];
    self.headerLine = headerLine;
    
    // 关闭按钮
    UIImageView *iv_close = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_close_black"]];
    iv_close.contentMode = UIViewContentModeCenter;
    [self addSubview:iv_close];
    
    [iv_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.top.equalTo(weakSelf).offset(20);
        make.left.equalTo(weakSelf);
    }];
    
    [iv_close setUserInteractionEnabled:YES];
    [iv_close bk_whenTapped:^{
        [UIView animateWithDuration:0.24 animations:^{
            weakSelf.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
        }];
    }];
    
    // 重置按钮
    UIButton *resetBtn = [[UIButton alloc] init];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:COLOR_GRAY_999999 forState:UIControlStateNormal];
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:resetBtn];
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@44);
        make.top.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf);
    }];
    
    [resetBtn bk_addEventHandler:^(id sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    // 确定按钮
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(weakSelf);
        make.height.equalTo(@66);
    }];
    self.bottomView = bottomView;
    
    SolidLine *solidLine = [SolidLine line:CGRectZero orient:LineOrient_RectUp color:COLOR_GRAY_999999];
    __weak typeof(bottomView) weakBottomView = bottomView;
    [bottomView addSubview:solidLine];
    [solidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakBottomView);
        make.height.equalTo(@1);
    }];
    
    UIButton *bottomBtn = [[UIButton alloc] init];
    bottomBtn.backgroundColor = COLOR_GRAY_333333;
    [bottomBtn cornerRadius:4.0];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [bottomView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakBottomView).offset(10.0);
        make.bottom.right.equalTo(weakBottomView).offset(-10.0);
    }];
    
    // TableView
    [self leftView];
    [self rightView];
    
}

- (FJTableView *)leftView {
    if (_leftView == nil) {
        _leftView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor yellowColor]];
        [self addSubview:_leftView];
        __weak typeof(self) weakSelf = self;
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf);
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.width.equalTo(@100);
        }];
    }
    return _leftView;
}

- (FJTableView *)rightView {
    if (_rightView == nil) {
        _rightView = [FJTableView FJTableView:CGRectZero editStyle:0 seperatorStyle:0 bgColor:[UIColor greenColor]];
        [self addSubview:_rightView];
        __weak typeof(self) weakSelf = self;
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.headerLine.mas_bottom);
            make.left.equalTo(weakSelf.leftView.mas_right);
            make.bottom.equalTo(weakSelf.bottomView.mas_top);
            make.right.equalTo(weakSelf);
        }];
    }
    return _rightView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
