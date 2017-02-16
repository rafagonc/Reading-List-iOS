//
//  REDBookPagesCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"
#import "REDBookCreationChainProtocol.h"

@class REDBookPagesCell;
@protocol REDBookPagesCellDelegate <NSObject>

-(void)pagesCell:(REDBookPagesCell *)pagesCell didChangeBookPages:(NSUInteger)pages;

@end

@interface REDBookPagesCell : UITableViewCell

<REDBookCreationChainProtocol>

#pragma mark - properties
@property (nonatomic, assign) NSUInteger pages;
@property (nonatomic, assign) id<REDBookPagesCellDelegate> delegate;

@end
