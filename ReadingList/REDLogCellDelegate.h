//
//  REDLogCellDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/26/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDBookProtocol.h"

@class REDLogCell;
@protocol REDLogCellDelegate <NSObject>

-(void)logCell:(REDLogCell *)logCell wantsToCheckOutBook:(id<REDBookProtocol>)book;

@end
