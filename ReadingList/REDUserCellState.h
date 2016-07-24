//
//  REDUserCellState.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDPageScrollView.h"
#import "REDUserCellStateDelegate.h"

@protocol REDUserCellState <NSObject>

-(void)populateScrollView:(REDPageScrollView *)scrollView andCallback:(void(^)(CGSize contentSize))callback;
-(BOOL)hidePageControl;
-(void)layoutViews;

@property id<REDUserCellStateDelegate> delegate;

@end
