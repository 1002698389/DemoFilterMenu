//
//  FJCollectionView+FJRefresh.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/11.
//  Copyright © 2017年 Jeff. All rights reserved.
//

@interface FJCollectionView (FJRefresh)

// 结束header的加载
- (void)header_endRefreshing;

// 结束footer最后一页的加载（有HintView）
- (void)footer_endRefreshingWithNoMoreData;

// 结束footer最后一页的加载（无HintView）
- (void)footer_endRefreshingWithNoMoreDataNoHint;

// 结束footer加载
- (void)footer_endRefreshing;

// 重置footer状态
- (void)footer_resetState;

@end
