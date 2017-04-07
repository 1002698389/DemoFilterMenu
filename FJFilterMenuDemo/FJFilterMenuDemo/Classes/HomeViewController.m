//
//  HomeViewController.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/7.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "HomeViewController.h"
#import <Masonry/Masonry.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup Home Page UI
    __weak typeof(self) weakSelf = self;
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Eddie"]];
    [self.view addSubview:backgroundView];
    [backgroundView setContentMode:UIViewContentModeScaleAspectFill];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
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
