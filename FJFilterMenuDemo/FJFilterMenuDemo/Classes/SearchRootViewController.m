//
//  SearchRootViewController.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/7.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SearchRootViewController.h"
#import "HomeViewController.h"


#define LeftViewMargin  (10.0 + 5.0)
#define TextFieldHeight (UI_NAVIGATION_BAR_HEIGHT - 20.0)

@interface SearchRootViewController ()

@end

@implementation SearchRootViewController

- (instancetype)init
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    self = [super initWithRootVC:homeVC];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
