//
//  FJTagCollectionView.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/7.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FJTagConfig;

@interface FJTagCollectionView : UIView

// 设置点击Tag事件的Block
@property (nonatomic, copy) void(^tagTappedBlock)(NSString *tag);

// 设置Multi点击Tag事件的Block
@property (nonatomic, copy) void(^tagMultiTappedBlock)(NSString *tag, BOOL selected);

// 添加Tags
- (void)addTags:(NSArray<NSString *> *)tags;

// 添加Tags(Config)
- (void)addTags:(NSArray<NSString *> *)tags config:(FJTagConfig*)config;

// 添加Tags(Config, 已经选择的SelectedTags)
- (void)addTags:(NSArray<NSString *> *)tags config:(FJTagConfig*)config selectedTags:(NSArray<NSString *> *)selectedTags;

// 插入Tags
- (void)insertTag:(NSString *)tag atIndex:(NSUInteger)index;

// 插入Tags(Config)
- (void)insertTag:(NSString *)tag atIndex:(NSUInteger)index config:(FJTagConfig*)config;

// 删除Tags(名称)
- (void)removeTag:(NSString*)tag;

// 删除Tags(Index)
- (void)removeTagAt:(NSUInteger)index;

// 删除所有Tags
- (void)removeAllTags;

// 设置CollectionView的Origin位置
- (void)setTagViewOrigin:(CGPoint)origin;

// 设置CollectionView的宽
- (void)setTagViewWidth:(CGFloat)width;

// 获取TagCollectionView的大小
- (CGSize)getTagViewSize;

// 获取所有Tags
- (NSArray<NSString *> *)allTags;

// 刷新UI
- (void)refresh;

// 计算控件高度
+ (CGSize)calculateSize:(CGFloat)width tags:(NSArray<NSString *> *)tags config:(FJTagConfig*)config;

@end
