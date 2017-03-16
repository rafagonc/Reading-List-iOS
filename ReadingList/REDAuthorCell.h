//
//  REDAuthorCell.h
//  ReadingList
//
//  Created by Banco Santander Brasil on 7/7/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorProtocol.h"
#import <UIKit/UIKit.h>

@class REDAuthorCell;
@protocol REDAuthorCellDelegate <NSObject>

-(void)authorCell:(REDAuthorCell *)cell wantsToEditAuthor:(id<REDAuthorProtocol>)author;

@end

@interface REDAuthorCell : UITableViewCell

#pragma mark - properties
@property (nonatomic,weak) id<REDAuthorProtocol> author;
@property (nonatomic,weak) id<REDAuthorCellDelegate> delegate;


@end
