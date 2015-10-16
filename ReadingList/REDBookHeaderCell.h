//
//  REDBookHeaderCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"
#import "REDBookCreationChainProtocol.h"

@class REDBookHeaderCell;
@protocol REDBookHeaderCellDelegate <NSObject>

-(void)didSelectAuthorInBookHeaderCell:(REDBookHeaderCell *)headerCell;
-(void)didSelectCoverInBookHeaderCell:(REDBookHeaderCell *)headerCell;

@end


@interface REDBookHeaderCell : UITableViewCell

<REDBookCreationChainProtocol>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;

#pragma mark - properties
@property (nonatomic,weak) id<REDBookProtocol> book;
@property (nonatomic,weak) id<REDAuthorProtocol> author;
@property (nonatomic,weak) id<REDBookHeaderCellDelegate> delegate;

@end
