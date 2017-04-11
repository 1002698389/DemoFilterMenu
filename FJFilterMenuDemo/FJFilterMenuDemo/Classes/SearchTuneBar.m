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

@property (nonatomic, assign) SearchTuneValue value;
@property (nonatomic, assign) BOOL price_asc;

@end

@implementation SearchTuneBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.value = SearchTuneValue_Hot;
    self.price_asc = YES;
    self.btn_hot.tag = SearchTuneValue_Hot;
    self.btn_discount.tag = SearchTuneValue_Discount;
    self.btn_price.tag = SearchTuneValue_Price;
    self.btn_filter.tag = SearchTuneValue_Filter;
    
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

- (void)setHasFilter:(BOOL)hasFilter
{
    _hasFilter = hasFilter;
    
    if (hasFilter) {
        self.lb_filter.textColor = COLOR_SELECT;
    }else {
        self.lb_filter.textColor = COLOR_UNSELECT;
    }
}

- (void)selecteTab:(SearchTuneValue)value
{
    switch (value) {
        case SearchTuneValue_Hot:
        {
            if (self.value == SearchTuneValue_Hot) {
                return;
            }
            
            self.value = SearchTuneValue_Hot;
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_SELECT;
            self.lb_discount.textColor = COLOR_UNSELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
            
        case SearchTuneValue_Discount:
        {
            if (self.value == SearchTuneValue_Discount) {
                return;
            }
            
            self.value = SearchTuneValue_Discount;
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_UNSELECT;
            self.lb_discount.textColor = COLOR_SELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
        case SearchTuneValue_Price:
        {
            if (self.value == SearchTuneValue_Price) {
                self.price_asc = !self.price_asc;
            }else{
                self.value = SearchTuneValue_Price;
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
        case SearchTuneValue_Filter:
        {
        }
            break;
            
        default:
            break;
    }
}

- (void)tap:(UIButton*)btn {
    SearchTuneValue value = btn.tag;
    
    switch (value) {
        case SearchTuneValue_Hot:
        {
            if (self.value == SearchTuneValue_Hot) {
                return;
            }
            
            self.value = SearchTuneValue_Hot;
            MF_BLOCK_CALL_2_P(self.searchTuneBarBlock, SearchTuneValue_Hot, NO);
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_SELECT;
            self.lb_discount.textColor = COLOR_UNSELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
        
        case SearchTuneValue_Discount:
        {
            if (self.value == SearchTuneValue_Discount) {
                return;
            }
            
            self.value = SearchTuneValue_Discount;
            MF_BLOCK_CALL_2_P(self.searchTuneBarBlock, SearchTuneValue_Discount, NO);
            
            // UI
            [self.iv_asc setHighlighted:NO];
            [self.iv_desc setHighlighted:NO];
            self.lb_hot.textColor = COLOR_UNSELECT;
            self.lb_discount.textColor = COLOR_SELECT;
            self.lb_price.textColor = COLOR_UNSELECT;
        }
            break;
        case SearchTuneValue_Price:
        {
            if (self.value == SearchTuneValue_Price) {
                self.price_asc = !self.price_asc;
            }else{
                self.value = SearchTuneValue_Price;
            }
            MF_BLOCK_CALL_2_P(self.searchTuneBarBlock, SearchTuneValue_Price, self.price_asc);
            
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
        case SearchTuneValue_Filter:
        {
            MF_BLOCK_CALL_2_P(self.searchTuneBarBlock, SearchTuneValue_Filter, NO);
        }
            break;
            
        default:
            break;
    }
    
}

@end
