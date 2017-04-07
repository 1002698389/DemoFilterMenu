//
//  SearchRootViewController.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/7.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchRootViewController.h"
#import <Masonry/Masonry.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import <FJTool/FJTool.h>
#import <FJController/FJControllerHeader.h>

#import "HomeViewController.h"
#import "SearchHistoryView.h"

#define LeftViewMargin  (10.0 + 5.0)
#define TextFieldHeight (UI_NAVIGATION_BAR_HEIGHT - 20.0)

@interface SearchRootViewController ()

@property (nonatomic, strong) SearchHistoryView *searchHistoryView;

@end

@implementation SearchRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearchBar];
    // Add HomeViewController
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildViewController:homeVC];
    [self.view addSubview:homeVC.view];
    __weak typeof(self) weakSelf = self;
    [homeVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)setupSearchBar {
    __weak typeof(self) weakSelf = self;
    // Setup UI
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH , TextFieldHeight)];
    [tf cornerRadius:tf.height / 2.0 borderWidth:0.5 boderColor:COLOR_GRAY_CCCCCC];
    tf.placeholder = @"搜索商品";
    tf.font = [UIFont systemFontOfSize:12.0];
    tf.textColor = COLOR_GRAY_333333;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navigationItem.titleView = tf;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tf.height / 2.0 + LeftViewMargin, tf.height / 2.0)];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    [leftView addSubview:icon];
    icon.clipsToBounds = YES;
    icon.contentMode = UIViewContentModeScaleAspectFit;
    __weak typeof(leftView) weakLeftView = leftView;
    __weak typeof(tf) weakTf = tf;
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakLeftView).offset(-5.0);
        make.top.bottom.equalTo(weakLeftView);
        make.width.equalTo(@(weakTf.height / 2.0));
    }];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = leftView;
    
    UIView *leftEmpty = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 24.0)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftEmpty];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 24.0)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLOR_GRAY_CCCCCC forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    [cancelBtn bk_addEventHandler:^(id sender) {
        [weakTf resignFirstResponder];
        [weakSelf showLeftView];
        weakSelf.searchHistoryView.hidden = YES;
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    tf.bk_didBeginEditingBlock = ^(UITextField *textField) {
        [weakSelf hideLeftView];
        weakSelf.searchHistoryView.hidden = NO;
    };
}

- (void)hideLeftView {
    
    if (self.navigationItem.leftBarButtonItem.customView.width <= 5.0 ) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.015 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIView *leftEmpty = weakSelf.navigationItem.leftBarButtonItem.customView;
        leftEmpty.frame = CGRectMake(0, 0, leftEmpty.bounds.size.width - 4.0, leftEmpty.bounds.size.height);
        weakSelf.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftEmpty];
        [weakSelf hideLeftView];
    });
}

- (void)showLeftView {
    if (self.navigationItem.leftBarButtonItem.customView.width >= 40.0 ) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.015 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIView *leftEmpty = weakSelf.navigationItem.leftBarButtonItem.customView;
        leftEmpty.frame = CGRectMake(0, 0, leftEmpty.bounds.size.width + 4.0, leftEmpty.bounds.size.height);
        weakSelf.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftEmpty];
        [weakSelf showLeftView];
    });
}

- (SearchHistoryView *)searchHistoryView {
    if (_searchHistoryView == nil) {
        _searchHistoryView = [[SearchHistoryView alloc] init];
        _searchHistoryView.backgroundColor = [UIColor whiteColor];
        [MF_Key_Window addSubview:_searchHistoryView];
        [_searchHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(MF_Key_Window);
            make.top.equalTo(MF_Key_Window).offset(64.0);
        }];
    }
    return _searchHistoryView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
