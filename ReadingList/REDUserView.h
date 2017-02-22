//
//  REDUserView.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDUserViewDelegate.h"
#import "REDUserProtocol.h"

@interface REDUserView : UIView

#pragma mark - properties
@property (nonatomic,weak) id<REDUserProtocol> user;
@property (nonatomic,weak) id<REDUserViewDelegate> delegate;

@end
