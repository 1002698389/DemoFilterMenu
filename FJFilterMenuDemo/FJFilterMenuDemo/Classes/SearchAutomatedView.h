//
//  SearchAutomatedView.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAutomatedView : UIView

@property (nonatomic, copy) void(^tagTapped)(NSString *tag);
@property (nonatomic, copy) void(^tagScrolled)(void);

- (void)refresh:(NSString*)keyword;

@end
