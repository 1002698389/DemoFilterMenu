//
//  SearchHistoryCell.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>
#import "FJTagModel.h"

typedef NS_ENUM(NSInteger, TagAction) {
    TagAction_Deletion,
    TagAction_Tapped,
};

@interface SearchHistoryCell : FJCell

@end

@interface SearchHistoryCellDataSource : FJCellDataSource

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL disableDeletion;
@property (nonatomic, strong) NSArray<FJTagModel *> *tags;

@property (nonatomic, assign) TagAction action;
@property (nonatomic, copy)   NSString *tag;

@end
