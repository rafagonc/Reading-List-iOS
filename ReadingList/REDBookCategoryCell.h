//
//  REDCategoryCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDCategoryProtocol.h"

@protocol REDBookCategoryCellDelegate <NSObject>

-(void)tableView

@end

@interface REDBookCategoryCell : UITableViewCell

#pragma mark - properties
@property (nonatomic,weak) id<REDCategoryProtocol> category;

@end

