//
//  FilterSelectModel.h
//  FJFilterMenuDemo
//

#import "FJTagModel.h"

typedef NS_ENUM(NSInteger, FilterType) {
    FilterType_Category,
    FilterType_Brand,
    FilterType_Seller,
    FilterType_Price
};

@protocol FilterSelectModel;

@interface FilterSelectModel : FJTagModel

@property (assign, nonatomic) FilterType type;
@property (assign, nonatomic) BOOL selected;
// Tag上显示的group名称 , 或者Brand Seller名称和搜索字
@property (strong, nonatomic) NSString<Optional> *name;
// Group、Seller、Brand搜索字，Group如果是3层, XX->YY->ZZ , 如果是2层, XX-YY, 如果是1层（某个分类的全部）XX, 如果是全部，nil 或 空
@property (strong, nonatomic) NSString<Optional> *groupSearchName;
// Price的价格区间，如果是[0,0]表示全部价格，否则代表某个价格区间
@property (nonatomic, assign) int lowestPrice;
@property (nonatomic, assign) int highestPrice;

+ (FilterSelectModel *)filterSelectModel:(FilterType)type name:(NSString *)name;

+ (FilterSelectModel *)filterSelectModel:(FilterType)type name:(NSString *)name groupSearchName:(NSString *)groupSearchName lowestPrice:(int)lowestPrice hightestPrice:(int)hightestPrice;

+ (NSMutableArray<FilterSelectModel *> *)fake:(NSArray<NSString *> *)names type:(FilterType)type;

@end

@protocol FilterSelectModel <NSObject>

@end
