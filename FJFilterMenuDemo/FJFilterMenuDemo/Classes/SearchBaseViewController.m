//
//  SearchBaseViewController.m
//  FJFilterMenuDemo
//

#import "SearchBaseViewController.h"
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>

#import "FJTagCollectionView.h"
#import "FJTagConfig.h"
#import "SearchNavBarButton.h"
#import "SearchHistoryView.h"
#import "SearchAutomatedView.h"
#import "SearchResultViewController.h"
#import "MessageViewController.h"

#define LeftViewMargin  (10.0 + 5.0)
#define TextFieldHeight (24.0)

@interface SearchBaseViewController ()

@property (nonatomic, strong) UIViewController *rootVC;
@property (nonatomic, strong) SearchNavBarButton *searchNavBarButton;
@property (nonatomic, strong) SearchHistoryView *searchHistoryView;
@property (nonatomic, strong) SearchAutomatedView *searchAutomatedView;
@property (nonatomic, assign) BOOL searchHistory;


@end

@implementation SearchBaseViewController

- (instancetype)initWithRootVC:(UIViewController*)rootVC
{
    self = [super init];
    if (self) {
        self.rootVC = rootVC;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupSearchBar];
    
    // Add RootViewController
    [self addChildViewController:self.rootVC];
    [self.view addSubview:self.rootVC.view];
    __weak typeof(self) weakSelf = self;
    [self.rootVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

- (void)setupSearchBar {
    
    __weak typeof(self) weakSelf = self;
    // Setup UI
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH , TextFieldHeight)];
    [tf cornerRadius:4.0];
    tf.backgroundColor = COLOR_GRAY_F0F0F0;
    tf.tintColor = COLOR_GRAY_999999;
    tf.placeholder = @"搜索商品";
    tf.font = [UIFont systemFontOfSize:12.0];
    tf.textColor = COLOR_GRAY_333333;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.returnKeyType = UIReturnKeySearch;
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
    
    
    UIBarButtonItem *barSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    barSpace.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[barSpace, [[UIBarButtonItem alloc] initWithCustomView:self.searchNavBarButton]];
    [self.searchNavBarButton setUserInteractionEnabled:YES];
    __weak typeof(self.searchNavBarButton) weakSearchNavBarButton = self.searchNavBarButton;
    [self.searchNavBarButton.cancelBtn bk_addEventHandler:^(id sender) {
        
        [weakSearchNavBarButton switchTo:0];
        weakSelf.searchHistory = NO;
        
        [weakTf resignFirstResponder];
        [weakSelf restoreSearchBarAnimation];
        weakSelf.searchHistoryView.hidden = YES;
        weakTf.text = nil;
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchNavBarButton.messageBtn bk_addEventHandler:^(id sender) {
        
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        [weakSelf.navigationController pushViewController:messageVC animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    tf.bk_didBeginEditingBlock = ^(UITextField *textField) {
        if (weakSelf.searchHistory) {
            return;
        }
        
        [weakSelf expandSearchBarAnimation];
        weakSelf.searchHistoryView.hidden = NO;
        [weakSelf.searchHistoryView refresh:YES];

        [weakSearchNavBarButton switchTo:1];
        weakSelf.searchHistory = YES;
    };
    
    tf.bk_shouldReturnBlock = ^BOOL(UITextField *textfield) {
        [textfield resignFirstResponder];
        [weakSelf searchTag:textfield.text save:YES];
        textfield.text = nil;
        return YES;
    };
    
    [[tf.rac_textSignal throttle:0.5] subscribeNext:^(NSString *txt) {
        if ([txt trimString:TrimType_WhiteSpaneAndNewline].length > 0) {
            weakSelf.searchAutomatedView.hidden = NO;
            [weakSelf.searchAutomatedView refresh:txt];
        }else{
            weakSelf.searchAutomatedView.hidden = YES;
            _searchHistoryView.hidden = NO;
        }
    }];
}

// SearchNavBarButton
- (SearchNavBarButton *)searchNavBarButton {
    if (_searchNavBarButton == nil) {
        _searchNavBarButton = [[SearchNavBarButton alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
        [_searchNavBarButton setupUI];
    }
    return _searchNavBarButton;
}

// SearchHistoryView
- (SearchHistoryView *)searchHistoryView {
    if (_searchHistoryView == nil) {
        _searchHistoryView = [[SearchHistoryView alloc] init];
        _searchHistoryView.backgroundColor = [UIColor whiteColor];
        [MF_Key_Window addSubview:_searchHistoryView];
        [_searchHistoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(MF_Key_Window);
            make.top.equalTo(MF_Key_Window).offset(64.0);
        }];
        _searchHistoryView.backgroundColor = [UIColor whiteColor];
        MF_WEAK_SELF(self);
        
        // Search View Tag Tapped
        _searchHistoryView.tagTapped = ^(NSString *tag) {
            UITextField *tf = (UITextField *)weakSelf.navigationItem.titleView;
            [tf resignFirstResponder];
            tf.text = nil;
            [weakSelf searchTag:tag save:NO];
        };
        
        // Search View Scrolled
        _searchHistoryView.tagScrolled = ^{
            UITextField *tf = (UITextField *)weakSelf.navigationItem.titleView;
            [tf resignFirstResponder];
        };
    }
    [MF_Key_Window bringSubviewToFront:_searchHistoryView];
    return _searchHistoryView;
}

// SearchAutomatedView
- (SearchAutomatedView *)searchAutomatedView {
    if (_searchAutomatedView == nil) {
        _searchAutomatedView = [[SearchAutomatedView alloc] init];
        [MF_Key_Window addSubview:_searchAutomatedView];
        [_searchAutomatedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(MF_Key_Window);
            make.top.equalTo(MF_Key_Window).offset(64.0);
        }];
        _searchAutomatedView.backgroundColor = [UIColor whiteColor];
        MF_WEAK_SELF(self);
        
        // Search View Tag Tapped
        _searchAutomatedView.tagTapped = ^(NSString *tag) {
            UITextField *tf = (UITextField *)weakSelf.navigationItem.titleView;
            [tf resignFirstResponder];
            tf.text = nil;
            [weakSelf searchTag:tag save:NO];
        };
        
        // Search View Scrolled
        _searchAutomatedView.tagScrolled = ^{
            UITextField *tf = (UITextField *)weakSelf.navigationItem.titleView;
            [tf resignFirstResponder];
        };
    }
    [MF_Key_Window bringSubviewToFront:_searchAutomatedView];
    return _searchAutomatedView;
}

// 导航栏隐藏左侧按钮
- (void)expandSearchBarAnimation {
    
    if (self.navigationItem.leftBarButtonItem.customView.width <= 5.0 ) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.015 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIView *leftEmpty = weakSelf.navigationItem.leftBarButtonItem.customView;
        leftEmpty.frame = CGRectMake(0, 0, leftEmpty.bounds.size.width - 4.0, leftEmpty.bounds.size.height);
        weakSelf.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftEmpty];
        [weakSelf expandSearchBarAnimation];
    });
}

// 导航栏显示左侧按钮
- (void)restoreSearchBarAnimation {
    if (self.navigationItem.leftBarButtonItem.customView.width >= 40.0 ) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.015 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIView *leftEmpty = weakSelf.navigationItem.leftBarButtonItem.customView;
        leftEmpty.frame = CGRectMake(0, 0, leftEmpty.bounds.size.width + 4.0, leftEmpty.bounds.size.height);
        weakSelf.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftEmpty];
        [weakSelf restoreSearchBarAnimation];
    });
}

// Search Tag
- (void)searchTag:(NSString*)tag save:(BOOL)save {
    
    // 保存Recent Search
    NSString *trimmedTag = [tag trimString:TrimType_WhiteSpaneAndNewline];
    if (trimmedTag.length > 0 && save) {
        NSMutableArray *recentSearchTags = [FJStorage value_nsobject:@"RecentSearch"];
        if (recentSearchTags == nil || [recentSearchTags count] == 0) {
            recentSearchTags = [NSMutableArray arrayWithArray:recentSearchTags];
            [recentSearchTags addObject:trimmedTag];
            [FJStorage save_nsobject:recentSearchTags key:@"RecentSearch"];
        }else{
            
            NSMutableSet *recentPool = [NSMutableSet setWithArray:recentSearchTags];
            [recentPool addObject:trimmedTag];
            [FJStorage save_nsobject:[recentPool allObjects] key:@"RecentSearch"];
        }
    }
    
    [_searchHistoryView removeFromSuperview];
    [_searchAutomatedView removeFromSuperview];
    _searchHistoryView = nil;
    _searchAutomatedView = nil;
    [self restoreSearchBarAnimation];
    
    SearchResultViewController *searchResultVC = [[SearchResultViewController alloc] init];
    [searchResultVC updateSearchCriteria:tag query:nil];
    [self.navigationController pushViewController:searchResultVC animated:YES];
    
    [self.searchNavBarButton switchTo:0];
    self.searchHistory = NO;
    
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
