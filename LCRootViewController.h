#import <UIKit/UIKit.h>

@interface LCRootViewController : UITableViewController <UIDocumentPickerDelegate>
@property(nonatomic) NSString* acError;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isGridView;

@end
