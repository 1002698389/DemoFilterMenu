//
//  MessageViewController.m
//  FJFilterMenuDemo
//

#import "MessageViewController.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"

@interface MessageViewController ()

@property (nonatomic, strong) FJTagCollectionView *tagView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_TEXT_BANANA;
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.text = @"Message";
    [lb sizeToFit];
    lb.center = self.view.center;

    FJTagConfig *config = [FJTagConfig new];
    config.enableMultiTap = YES;
    [self.tagView addTags:@[@"AAAAAAA",@"BBBBB",@"CCCCCCCC",@"DDDDDDDDD",@"EEEEEE",@"FFFFFFFFFFFF"] config:config];
    [self.tagView refresh];
}

- (FJTagCollectionView *)tagView {
    if (_tagView == nil) {
        
        _tagView = [[FJTagCollectionView alloc] init];
        [_tagView setTagViewOrigin:CGPointMake(0, 30)];
        [self.view addSubview:_tagView];
        [_tagView setTagViewWidth:UI_SCREEN_WIDTH];
        MF_WEAK_SELF(self);
        _tagView.tagTappedBlock = ^(NSString *tag) {
            
        };
    }
    return _tagView;
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
