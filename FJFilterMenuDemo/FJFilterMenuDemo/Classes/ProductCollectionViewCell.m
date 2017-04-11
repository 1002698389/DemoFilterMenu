//
//  ProductCollectionViewCell.m
//  FJFilterMenuDemo
//

#import "ProductCollectionViewCell.h"

@interface ProductCollectionViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *iv_product;

@end

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellDataSource:(__kindof FJCollectionCellDataSource *)cellDataSource {
    [super setCellDataSource:cellDataSource];
    ProductCollectionViewCellDataSource *ds = cellDataSource;
    [self.iv_product setImage:[UIImage imageNamed:ds.imageURL]];
}


@end


@implementation ProductCollectionViewCellDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat w = UI_SCREEN_WIDTH / 2.0 - 20.0;
        self.size = CGSizeMake(w, w + 50.0);
    }
    return self;
}

@end
