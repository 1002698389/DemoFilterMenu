//
//  FilterSelectModel.m
//  FJFilterMenuDemo
//

#import "FilterSelectModel.h"


@implementation FilterSelectModel

- (NSString *)tag {
    switch (self.type) {
        case FilterType_Category:
        {
            return self.name;
        }
        case FilterType_Brand:
        {
            return self.name;
        }
        case FilterType_Seller:
        {
            return self.name;
        }
        case FilterType_Price:
        {
            return [NSString stringWithFormat:@"%d-%d",self.lowestPrice,self.highestPrice];
        }
    }
    return nil;
}

+ (FilterSelectModel *)filterSelectModel:(FilterType)type name:(NSString *)name {
    return [FilterSelectModel filterSelectModel:type name:name groupSearchName:name lowestPrice:0 hightestPrice:0];
}

+ (FilterSelectModel *)filterSelectModel:(FilterType)type name:(NSString *)name groupSearchName:(NSString *)groupSearchName lowestPrice:(int)lowestPrice hightestPrice:(int)hightestPrice {
    
    FilterSelectModel *model = [[FilterSelectModel alloc] init];
    model.type = type;
    model.name = name;
    model.groupSearchName = groupSearchName;
    model.lowestPrice = lowestPrice;
    model.highestPrice = hightestPrice;
    model.selected = NO;
    
    return model;
}

+ (NSMutableArray<FilterSelectModel *> *)fake:(NSArray<NSString *> *)names type:(FilterType)type {
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    for (NSString *name in names) {
        [ret addObject:[FilterSelectModel filterSelectModel:type name:name groupSearchName:name lowestPrice:0 hightestPrice:0]];
    }
    return ret;
}

@end
