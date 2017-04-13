//
//  SearchTuneBar.m
//  FJFilterMenuDemo
//

#import "SearchTuneBar.h"

#define COLOR_SELECT    COLOR_GRAY_26241F
#define COLOR_UNSELECT  COLOR_GRAY_999999

@interface SearchTuneBar()

@property (nonatomic, weak) IBOutlet UIButton *btn_hot;
@property (nonatomic, weak) IBOutlet UIButton *btn_discount;
@property (nonatomic, weak) IBOutlet UIButton *btn_price;
@property (nonatomic, weak) IBOutlet UIButton *btn_filter;
@property (nonatomic, weak) IBOutlet UIImageView *iv_asc;
@property (nonatomic, weak) IBOutlet UIImageView *iv_desc;
@property (nonatomic, weak) IBOutlet UILabel *lb_hot;
@property (nonatomic, weak) IBOutlet UILabel *lb_discount;
@property (nonatomic, weak) IBOutlet UILabel *lb_price;
@property (nonatomic, weak) IBOutlet UILabel *lb_filter;

@property (nonatomic, assign) SearchTab tab;
@property (nonatomic, assign) BOOL price_asc;

@property (assign, nonatomic) BOOL searchTabHighlighted;

@end

@implementation SearchTuneBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.tab = SearchTab_Hot;
    self.price_asc = YES;
    self.btn_hot.tag = SearchTab_Hot;
    self.btn_discount.tag = SearchTab_Discount;
    self.btn_price.tag = SearchTab_Price;
    self.btn_filter.tag = SearchTab_Filter;
    
    self.btn_hot.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.btn_discount.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.btn_price.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.btn_filter.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self.btn_hot addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_discount addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_price addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_filter addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.lb_hot.font = [UIFont systemFontOfSize:14.0];
    self.lb_hot.textColor = COLOR_SELECT;
    
    self.lb_price.font = [UIFont systemFontOfSize:14.0];
    self.lb_price.textColor = COLOR_UNSELECT;
    
    self.lb_discount.font = [UIFont systemFontOfSize:14.0];
    self.lb_discount.textColor = COLOR_UNSELECT;
    
    self.lb_filter.font = [UIFont systemFontOfSize:14.0];
    self.lb_filter.textColor = COLOR_UNSELECT;
    
}

// 高亮Search Tab
- (void)setSearchTabHighlighted:(BOOL)searchTabHighlighted {
    _searchTabHighlighted = searchTabHighlighted;
    if (searchTabHighlighted) {
        self.lb_filter.textColor = COLOR_SELECT;
    }else {
        self.lb_filter.textColor = COLOR_UNSELECT;
    }
}

// 点击某个Search Tab(有些是排序、有些是单击选项)
- (void)selecetSearchTab:(SearchTab)tab
{
    switch (tab) {
        case SearchTab_Hot:
        {
            if (self.tab == SearchTab_Hot) {
                return;
            }
            
            self.tab = SearchTab_Hot;
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_SELECT;
            self.lb_discount.textColor = COLOR_UNSELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
            
        case SearchTab_Discount:
        {
            if (self.tab == SearchTab_Discount) {
                return;
            }
            
            self.tab = SearchTab_Discount;
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_UNSELECT;
            self.lb_discount.textColor = COLOR_SELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
        case SearchTab_Price:
        {
            if (self.tab == SearchTab_Price) {
                self.price_asc = !self.price_asc;
            }else{
                self.tab = SearchTab_Price;
            }
            
            // UI
            if (self.price_asc) {
                [self.iv_asc setHighlighted:YES];
                [self.iv_desc setHighlighted:NO];
            }else{
                [self.iv_asc setHighlighted:NO];
                [self.iv_desc setHighlighted:YES];
            }
            self.lb_hot.textColor = COLOR_UNSELECT;
            self.lb_discount.textColor = COLOR_UNSELECT;
            self.lb_price.textColor = COLOR_SELECT;
        }
            break;
        case SearchTab_Filter:
        {
        }
            break;
    }
}

- (void)tap:(UIButton*)btn {
    SearchTab tab = (SearchTab)btn.tag;
    
    switch (tab) {
        case SearchTab_Hot:
        {
            if (self.tab == SearchTab_Hot) {
                return;
            }
            
            self.tab = SearchTab_Hot;
            MF_BLOCK_CALL_2_P(self.searchTabTappedBlock, SearchTab_Hot, NO);
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_SELECT;
            self.lb_discount.textColor = COLOR_UNSELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
        
        case SearchTab_Discount:
        {
            if (self.tab == SearchTab_Discount) {
                return;
            }
            
            self.tab = SearchTab_Discount;
            MF_BLOCK_CALL_2_P(self.searchTabTappedBlock, SearchTab_Discount, NO);
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_UNSELECT;
            self.lb_discount.textColor = COLOR_SELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
        case SearchTab_Price:
        {
            if (self.tab == SearchTab_Price) {
                self.price_asc = !self.price_asc;
            }else{
                self.tab = SearchTab_Price;
            }
            MF_BLOCK_CALL_2_P(self.searchTabTappedBlock, SearchTab_Price, self.price_asc);
            
            // UI
            if (self.price_asc) {
                [self.iv_asc setHighlighted:YES];
                [self.iv_desc setHighlighted:NO];
            }else{
                [self.iv_asc setHighlighted:NO];
                [self.iv_desc setHighlighted:YES];
            }
            self.lb_hot.textColor = COLOR_UNSELECT;
            self.lb_discount.textColor = COLOR_UNSELECT;
            self.lb_price.textColor = COLOR_SELECT;
        }
            break;
        case SearchTab_Filter:
        {
            MF_BLOCK_CALL_2_P(self.searchTabTappedBlock, SearchTab_Filter, NO);
        }
            break;
            
        default:
            break;
    }
    
}

@end
