//
//  CategoryFilterData.h
//  FJFilterMenuDemo
//

typedef NS_ENUM(NSInteger, CategoryFilterGroupType) {
    CategoryFilterGroupType_Category,
    CategoryFilterGroupType_Brand,
    CategoryFilterGroupType_Seller
};

@protocol CategoryFilterSelectModel, CategoryFilterGroup;

@interface CategoryFilterData : JSONModel

@property (strong, nonatomic) NSMutableArray<CategoryFilterGroup,Optional> *catValues;
@property (strong, nonatomic) NSMutableArray<CategoryFilterGroup,Optional> *brandValues;
@property (strong, nonatomic) NSMutableArray<CategoryFilterGroup,Optional> *sellerValues;

@end

@interface CategoryFilterGroup : JSONModel

@property (strong, nonatomic) NSString<Optional> *groupName;
@property (strong, nonatomic) NSMutableArray<CategoryFilterSelectModel,Optional> *items;

@end

@interface CategoryFilterSelectModel : JSONModel

@property (assign, nonatomic) CategoryFilterGroupType type;
@property (assign, nonatomic) BOOL selected;
// Tag显示
@property (strong, nonatomic) NSString<Optional> *name;
// Seach Product 参数（Category，Seller，Brand），if 3-level, XX->YY , if 2-level, XX
@property (strong, nonatomic) NSString<Optional> *searchName;

@end

@protocol CategoryFilterSelectModel <NSObject>

@end
