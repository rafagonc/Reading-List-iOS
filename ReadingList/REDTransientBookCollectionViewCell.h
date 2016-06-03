//
//  REDTransientBookCollectionViewCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDTransientBook.h"

@interface REDTransientBookCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) REDTransientBook * book;
@property (nonatomic,assign) BOOL added;

@end
