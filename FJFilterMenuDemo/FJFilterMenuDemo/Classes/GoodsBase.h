//
//  GoodsBase.h
//  FJFilterMenuDemo
//

#import "MyModel.h"

typedef NS_ENUM(NSInteger, GoodsBriefType) {
    // 后台（产品、链接H5、特卖、搜索）
    GoodsBriefTypeNormal,       //商品
    GoodsBriefTypeSpecial,      //专题
    GoodsBriefTypeAdv,          //广告 H5
    GoodsBriefTypeCategory,     //品类
    GoodsBriefTypeSpecialList   // 专题历史(本地定义)
};

@class SellerModel;
@interface GoodsBase : MyModel

@property (nonatomic, copy) NSString<Optional> *name;           // 标题
@property (nonatomic, assign) float mallPrice;                  // 商城价(单位:¥)
@property (nonatomic, assign) float realPrice;                  // 现价
@property (nonatomic, assign) float mallPriceOrg;               // 商城价(外币单位)
@property (nonatomic, assign) float realPriceOrg;               // 现价

@property (nonatomic, copy) NSString<Optional> *coverImgUrl;    // 海报
@property (nonatomic, copy) NSString<Optional> *brand;          // 品牌
@property (nonatomic, copy) NSString<Optional> *country;        // 国家
@property (nonatomic, copy) NSString<Optional> *sellerName;     // 商户平台

@property (nonatomic, copy) NSString<Optional> *spuid;          // 商品ID   (H5页面的Url后缀)
@property (nonatomic, copy) NSString<Optional> *DOCID;          // == spuid
@property (nonatomic, assign) int stock;
@property (assign, nonatomic) int inStock;

@property (strong, nonatomic) SellerModel<Optional> *sellerInfo;

// 收藏
@property (assign, nonatomic) BOOL is_star;
@property (assign, nonatomic) int star_count;

@property (nonatomic, copy) NSString<Optional> *small_icon;

// 售罄
- (BOOL)isSoldOut;

@end

@protocol GoodsBase

@end

@interface SellerModel : MyModel

@property (copy, nonatomic) NSString<Optional> *namecn;
@property (copy, nonatomic) NSString<Optional> *nameen;
@property (copy, nonatomic) NSString<Optional> *country;                    // 国家
@property (copy, nonatomic) NSString<Optional> *flag;                          // 国旗
@property (copy, nonatomic) NSString<Optional> *logo;                         // 商家logo
@property (copy, nonatomic) NSString<Optional> *descriptioncn;

@end
