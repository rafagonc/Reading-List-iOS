//
//  REDAddNoteCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIStaticTableView.h"

@class REDAddNoteCell;

@protocol REDAddNoteCellDelegate <NSObject>

-(void)addNoteCellWantsToAddNote:(REDAddNoteCell *)cell;

@end

@interface REDAddNoteCell : UITableViewCell

@property (nonatomic,weak) id<REDAddNoteCellDelegate> delegate;

@end
