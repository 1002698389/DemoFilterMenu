//
//  FJTagConfig.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJTagConfig : NSObject

// Tag的字体颜色
@property (nonatomic, strong) UIColor *tagTextColor;

// Tag的背景颜色
@property (nonatomic, strong) UIColor *tagBackgroundColor;

// Tag的边框颜色
@property (nonatomic, strong) UIColor *tagBorderColor;

// Tag的字体
@property (nonatomic, strong) UIFont *tagTextFont;

// Tag的边框宽度
@property (nonatomic, assign) CGFloat tagBorderWidth;

// Tag的Corner Radius
@property (nonatomic, assign) CGFloat tagCornerRadius;

// Padding Top
@property (nonatomic, assign) CGFloat paddingTop;

// Padding Left
@property (nonatomic, assign) CGFloat paddingLeft;

// Padding Bottom
@property (nonatomic, assign) CGFloat paddingBottom;

// Padding Right
@property (nonatomic, assign) CGFloat paddingRight;

// Item Horizontal Space
@property (nonatomic, assign) CGFloat itemHorizontalSpace;

// Item Vertical Space
@property (nonatomic, assign) CGFloat itemVerticalSpace;

// Item Minmun Width
@property (nonatomic, assign) CGFloat itemMinWidth;

// Item Minmun Height
@property (nonatomic, assign) CGFloat itemMinHeight;

// Item Padding Left&Right
@property (nonatomic, assign) CGFloat itemPadding;

@end
