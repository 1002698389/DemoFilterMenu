//
//  ProductCollectionViewCell.h
//  FJFilterMenuDemo
//

#import <UIKit/UIKit.h>

@interface ProductCollectionViewCell : FJCollectionCell

@end

@interface ProductCollectionViewCellDataSource : FJCollectionCellDataSource

@property (nonatomic, copy) NSString *imageURL;

@end
