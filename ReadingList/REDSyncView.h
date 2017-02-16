//
//  REDSyncView.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

@class REDSyncView;
@protocol REDSyncViewDelegate <NSObject>

-(void)syncViewWantsToAuthenticateWithView:(REDSyncView *)syncView;

@end

@interface REDSyncView : UIView

@property (nonatomic,weak) id<REDSyncViewDelegate> delegate;

@end
