//
//  REDUserScrollView.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDUserProtocol.h"
#import "REDUserViewDelegate.h"
#import "REDSyncView.h"

@interface REDUserScrollView : UIScrollView

@property (nonatomic,weak) id<REDUserProtocol> user;
@property (nonatomic,weak) id<REDUserViewDelegate> userViewDelegate;
@property (nonatomic,weak) id<REDSyncViewDelegate> syncViewDelegate;
@property (nonatomic,weak) UIPageControl *pageControl;
-(void)updateData;


@end
