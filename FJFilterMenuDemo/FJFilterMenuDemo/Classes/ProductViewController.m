//
//  ProductViewController.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/12.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageURL]];
    [self.view addSubview:iv];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    
    MF_WEAK_SELF(self);
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
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
