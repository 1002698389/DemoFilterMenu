//
//  PageModel.m
//  FJFilterMenuDemo
//

#import "PageModel.h"

@implementation PageModel

- (BOOL)isFirstPage {
    if (self.page == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isLastPage {
    if (self.allpage == self.page || self.allpage == 0) {
        return YES;
    }
    return NO;
}

@end
