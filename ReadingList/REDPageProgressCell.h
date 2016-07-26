//
//  REDPageProgressCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"

@class REDPageProgressCell;
@protocol REDPageProgressCellDelegate <NSObject>

-(void)pageProgressCell:(REDPageProgressCell *)cell tryingToSetPagesWhileIsZeroForBook:(id<REDBookProtocol>)book;
-(void)pageProgressCell:(REDPageProgressCell *)cell didCompleteBookReading:(id<REDBookProtocol>)book;

@end

@interface REDPageProgressCell : UITableViewCell

@property (nonatomic, weak) id<REDPageProgressCellDelegate> delegate;
@property (nonatomic, weak) id<REDBookProtocol> book;
@property (nonatomic, assign) NSUInteger pages;
@property (nonatomic, assign) NSUInteger pagesRead;
@property (nonatomic, assign) NSInteger diff;

@end
