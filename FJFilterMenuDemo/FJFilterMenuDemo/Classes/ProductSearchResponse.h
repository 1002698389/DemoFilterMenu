//
//  ProductSearchResponse.h
//  FJFilterMenuDemo
//

#import "GoodsBase.h"
#import "PageModel.h"
#import "CategoryFilterData.h"
#import "MyModel.h"

@class ProductSearchData, ProductGroup, ProductGroupBase;
@protocol ProductGroupBase, ProductGroup;

@interface ProductSearchResponse : MyModel

@property (strong, nonatomic) ProductSearchData<Optional> *data;

@end

@interface ProductSearchData : PageModel

@property (strong, nonatomic) NSMutableArray<ProductGroup, Optional> *group;
@property (strong, nonatomic) NSMutableArray<GoodsBase, Optional> *products;

// 用于过滤数据
@property (strong, nonatomic) NSString<Optional> *category;

@end


@interface ProductGroup : MyModel

@property (strong, nonatomic) NSString<Optional> *property;
@property (strong, nonatomic) NSMutableArray<ProductGroupBase, Optional> *labels;
//@property (assign, nonatomic) int document_count;

@end

@interface ProductGroupBase : MyModel

@property (strong, nonatomic) NSString<Optional> *label;
@property (strong, nonatomic) NSMutableArray<ProductGroupBase, Optional> *sub_labels;

@end
