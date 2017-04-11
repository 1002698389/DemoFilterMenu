//
//  FJCollectionView+FJRefresh.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/11.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJCollectionView+FJRefresh.h"

@implementation FJCollectionView (FJRefresh)

// 结束header的加载
- (void)header_endRefreshing {
    [(PeapotRefreshHeader*)self.collectionView.mj_header endRefreshing];
}

// 结束footer最后一页的加载（有HintView）
- (void)footer_endRefreshingWithNoMoreData {
    
    if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshBackFooter class]]) {
        [(PeapotRefreshBackFooter*)self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }else if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshAutoFooter class]]) {
        [(PeapotRefreshAutoFooter*)self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
}

// 结束footer最后一页的加载（无HintView）
- (void)footer_endRefreshingWithNoMoreDataNoHint {
    if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshBackFooter class]]) {
        [(PeapotRefreshBackFooter*)self.collectionView.mj_footer endRefreshingWithNoMoreDataNoHint];
    }else if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshAutoFooter class]]) {
        [(PeapotRefreshAutoFooter*)self.collectionView.mj_footer endRefreshingWithNoMoreDataNoHint];
    }
    
}

// 结束footer加载
- (void)footer_endRefreshing {
    
    if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshBackFooter class]]) {
        [(PeapotRefreshBackFooter*)self.collectionView.mj_footer endRefreshing];
    }else if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshAutoFooter class]]) {
        [(PeapotRefreshAutoFooter*)self.collectionView.mj_footer endRefreshing];
    }
    
}

// 重置footer状态
- (void)footer_resetState {
    
    if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshBackFooter class]]) {
        [(PeapotRefreshBackFooter*)self.collectionView.mj_footer resetFooterState];
    }else if ([[self collectionView].mj_footer isKindOfClass:[PeapotRefreshAutoFooter class]]) {
        [(PeapotRefreshAutoFooter*)self.collectionView.mj_footer resetFooterState];
    }
    
}

@end
