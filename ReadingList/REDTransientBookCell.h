//
//  REDTransientBookCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/26/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDTransientBook.h"

@class REDTransientBookCell;
@protocol REDTransientBookCellDelegate <NSObject>

-(void)transientBookCell:(REDTransientBookCell *)cell wantsToAddTransientBook:(REDTransientBook *)book;

@end

@interface REDTransientBookCell : UITableViewCell

@property (nonatomic,weak) REDTransientBook * book;
@property (nonatomic,weak) id<REDTransientBookCellDelegate> delegate;

@end
