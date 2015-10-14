//
//  REDCategoryCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDCategoryProtocol.h"

@class REDBookCategoryCell;

@protocol REDBookCategoryCellDelegate <NSObject>

-(void)didSelectCategoryCell:(REDBookCategoryCell *)cell;

@end

@interface REDBookCategoryCell : UITableViewCell

#pragma mark - properties
@property (nonatomic,strong) id<REDCategoryProtocol> category;
@property (nonatomic,weak) id<REDBookCategoryCellDelegate> delegate;

@end

