//
//  SearchHistoryCell.m
//  FJFilterMenuDemo
//

#import "SearchHistoryCell.h"
#import "FJTagCollectionView.h"
#import "FJTagConfig.h"

@interface SearchHistoryCell()

@property (nonatomic, strong) FJTagCollectionView *tagView;
@property (nonatomic, weak) IBOutlet UILabel *lb_title;
@property (nonatomic, weak) IBOutlet UIImageView *iv_deletion;
@property (nonatomic, weak) IBOutlet UILabel *lb_norecentsearch;

@end

@implementation SearchHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    MF_WEAK_SELF(self);
    [self.iv_deletion setUserInteractionEnabled:YES];
    [self.iv_deletion bk_whenTapped:^{
        SearchHistoryCellDataSource *ds = weakSelf.cellDataSource;
        ds.action = TagAction_Deletion;
        weakSelf.delegate == nil ? : [weakSelf.delegate fjcell_actionRespond:ds from:weakSelf];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellDataSource:(__kindof FJCellDataSource *)cellDataSource {
    [super setCellDataSource:cellDataSource];
    SearchHistoryCellDataSource *ds = cellDataSource;

    if (ds.tags == nil || [ds.tags count] == 0) {
        
        self.lb_norecentsearch.hidden = NO;
        self.tagView.hidden = YES;
        [_tagView removeAllTags];
        
        
    }else{
        
        self.lb_norecentsearch.hidden = YES;
        self.tagView.hidden = NO;
        [_tagView removeAllTags];
        [_tagView addTags:ds.tags];
        [_tagView refresh];
    }
    
    self.lb_title.text = ds.title;
    self.iv_deletion.hidden = ds.disableDeletion;
    
}

- (FJTagCollectionView *)tagView {
    if (_tagView == nil) {
        _tagView = [[FJTagCollectionView alloc] init];
        [_tagView setTagViewOrigin:CGPointMake(0, 30)];
        [self addSubview:_tagView];
        [_tagView setTagViewWidth:UI_SCREEN_WIDTH];
        MF_WEAK_SELF(self);
        _tagView.tagTappedBlock = ^(NSString *tag) {
            SearchHistoryCellDataSource *ds = weakSelf.cellDataSource;
            ds.action = TagAction_Tapped;
            ds.tag = tag;
            weakSelf.delegate == nil ? : [weakSelf.delegate fjcell_actionRespond:ds from:weakSelf];
        };
    }
    return _tagView;
}

@end


@implementation SearchHistoryCellDataSource

@end
