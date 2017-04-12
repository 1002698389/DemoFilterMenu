//
//  GoodsBase.m
//  FJFilterMenuDemo
//

#import "GoodsBase.h"

@implementation GoodsBase

- (NSString<Optional> *)spuid {
    if (MF_NULL_OR_EMPTY(_spuid)) {
        return _DOCID;
    }
    return _spuid;
}


- (BOOL)isSoldOut {
    if (self.inStock == 0) {
        return YES;
    }else if (self.inStock == 2) {
        if (self.stock == 0) {
            return YES;
        }
    }
    return NO;
}

@end

@implementation SellerModel

@end
