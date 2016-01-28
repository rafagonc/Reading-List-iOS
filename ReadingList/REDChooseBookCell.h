//
//  REDChooseBookCell.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDBookProtocol.h"
#import "UIStaticTableView.h"
#import "REDLogCreateChainProtocol.h"

@class REDChooseBookCell;
@protocol REDChooseBookCellDelegate <NSObject>

-(void)chooseBookCellWantsToChooseBook:(REDChooseBookCell *)cell;

@end

@interface REDChooseBookCell : UITableViewCell

<REDLogCreateChainProtocol>

@property (nonatomic,strong) id<REDBookProtocol> book;
@property (nonatomic,weak  ) id<REDChooseBookCellDelegate> delegate;

@end
