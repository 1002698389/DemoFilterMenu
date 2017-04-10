//
//  SearchAutomatedCell.h
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FJTableView/FJTableViewHeader.h>

@interface SearchAutomatedCell : FJCell

@end


@interface SearchAutomatedCellDataSource : FJCellDataSource

@property (nonatomic, copy) NSString *key;

@end
