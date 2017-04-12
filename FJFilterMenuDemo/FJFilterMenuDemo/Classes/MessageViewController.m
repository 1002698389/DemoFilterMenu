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
    config.tagTextFont = [UIFont systemFontOfSize:12.0];
    config.tagTextColor = COLOR_GRAY_666666;
    config.tagBackgroundColor = COLOR_TEXT_PURPLE;
    config.tagBorderColor = COLOR_PURE_CLEAR;
    config.tagBorderWidth = 0.5;
    config.tagCornerRadius = 2.0;
    config.itemMinWidth = 100.0;
    config.itemMinHeight = 26.0;
    config.paddingTop = 20.0;
    config.paddingLeft = 5.0;
    config.paddingBottom = 20.0;
    config.paddingRight = 5.0;
    config.itemHorizontalSpace = 18.0;
    config.itemVerticalSpace = 16.0;
    config.tagHighlightedTextFont = [UIFont systemFontOfSize:12.0];
    config.tagHighlightedTextColor = COLOR_GRAY_333333;
    config.tagHighlightedBackgroundColor = COLOR_PURE_WHITE;
    config.tagHighlightedBorderColor = COLOR_GRAY_26241F;
    config.selectedImage = @"icon_selected";
    config.selectedImageSize = CGSizeMake(12.0, 12.0);
    config.itemPaddingLeft = 5.0;
    config.itemPaddingRight = 5.0;
    config.debug = YES;
    
    [self.tagView addTags:@[@"全部男包",@"双肩包/背包",@"手提包",@"挎包",@"旅行包",@"钱包/卡包"] config:config];
    [self.tagView refresh];
}

- (FJTagCollectionView *)tagView {
    if (_tagView == nil) {
        
        _tagView = [[FJTagCollectionView alloc] init];
        [_tagView setTagViewOrigin:CGPointMake(0, 30)];
        [self.view addSubview:_tagView];
        [_tagView setTagViewWidth:UI_SCREEN_WIDTH];
        _tagView.tagMultiTappedBlock = ^(NSString *tag, BOOL selected) {
            NSLog(@"%@ %@", tag, selected?@"选中":@"未选中");
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
