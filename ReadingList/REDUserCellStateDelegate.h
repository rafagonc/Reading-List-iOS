//
//  REDUserCellStateDelegate.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol REDUserCellState;
@protocol REDUserCellStateDelegate <NSObject>

-(void)userStateWantsToAuthenticate:(id<REDUserCellState>)cell;
-(void)userStateWantsToOpenChart:(id<REDUserCellState>)cell;

@end
