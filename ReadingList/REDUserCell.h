//
//  REDUserCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDUserProtocol.h"
#import "UIStaticTableView.h"

@class REDUserCell;
@protocol REDUserCellDelegate <NSObject>

-(void)userCellWantsToOpen:(REDUserCell *)cell;

@end

@interface REDUserCell : UITableViewCell

<UIStaticTableViewCellCustomizationProtocol>

@property (nonatomic,weak) id<REDUserProtocol> user;
@property (nonatomic,weak) id<REDUserCellDelegate> delegate;

@end
