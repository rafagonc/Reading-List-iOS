//
//  REDSegmentedCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDLibraryViewController_Constants.h"

@class REDSegmentedCell;
@protocol REDSegmentedCellDelegate <NSObject>

-(void)segmetedCell:(REDSegmentedCell *)cell wantsToChangeType:(REDLibraryType)library;

@optional
-(void)segmetedCell:(REDSegmentedCell *)cell willChangeType:(REDLibraryType)library;

@end

@interface REDSegmentedCell : UITableViewCell

@property (nonatomic,weak) id<REDSegmentedCellDelegate> delegate;

@end
